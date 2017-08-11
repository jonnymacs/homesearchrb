class HomeSearch < Sinatra::Base

  get '/' do
    erb :index
  end

  get '/search' do

    # there are probably fancier ways to parse
    # this input, but this is not a bad start
    #
    parsed_params = params["query"].split(",")
    address = parsed_params[0].strip
    citystatezip = parsed_params[1..-1].join(",").strip

    # query the zillow api for the parsed address / citystatezip
    status, result = Zillow::Api.get_deep_search_results(address, citystatezip)

    case status
    when 200
      # parse the zillow response to an open structure
      @home = Zillow::ResultRepresenter.new(OpenStruct.new).from_hash(result)
      @home.has_details = false #if home were a real model, this would be a default...

      # see if we can get more details about this property
      detail_status, details = Zillow::Api.get_updated_property_details(@home.provider_id)
      if detail_status == 200
        @home = Zillow::PropertyDetailsRepresenter.new(@home).from_hash(details)
      end

      # render the result
      erb :_home, layout: false
    when 508
      erb :_no_result, layout: false
    else
      @message = result
      erb :_error, layout: false
    end

  end

end
