class HomeSearch < Sinatra::Base
  configure do
    $logger = Logger.new(STDOUT)
  end

  get '/' do
    erb :index
  end

  get '/search' do

    parsed_params = params["query"].split(",")
    address = parsed_params[0].strip
    citystatezip = parsed_params[1..-1].join(",").strip

    # query the zillow api for the parsed address / citystatezip
    status, result = Zillow.get_search_results(address, citystatezip)

    case status
    when 200
      # parse the zillow response to an open structure
      @home = ZillowResultRepresenter.new(OpenStruct.new).from_hash(result)
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
