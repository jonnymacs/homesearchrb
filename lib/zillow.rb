class Zillow
  include HTTParty
  base_uri 'http://www.zillow.com'
  format :xml

  def self.handle_response(response)
    return response.parsed_response["searchresults"]["response"]["results"]["result"] if response.code == 200
    # todo raise exception for
  end

  def self.get_search_results(address, citystatezip)
    path = "/webservice/GetSearchResults.htm"
    params = { address: address, citystatezip: citystatezip }
    params.merge!('zws-id': "X1-ZWz1dyb53fdhjf_6jziz")

    response = get("#{path}?#{Rack::Utils.build_query(params)}")
    handle_response(response)
  end

end
