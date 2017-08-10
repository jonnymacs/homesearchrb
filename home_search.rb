class HomeSearch < Sinatra::Base
  configure do
    $logger = Logger.new(STDOUT)
  end

  get '/' do
    erb :index
  end

  get '/search.json' do
    content_type :json

    # run the search
    result = Zillow.get_search_results(params[:address], params[:citystatezip])

    # parse the zillow response to an open structure
    home = ZillowResultRepresenter.new(OpenStruct.new).from_hash(result)

    #render the struct to the client
    HomeRepresenter.new(home).to_json
  end
end
