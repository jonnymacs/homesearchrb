class Zillow
  include HTTParty
  base_uri 'http://www.zillow.com'
  format :xml

  def self.handle_response(response)
    # api returns 200 even on failure...
    if response.code == 200
      # check the real response code...
      code = response.parsed_response["searchresults"]["message"]["code"].to_i
      return 200, response.parsed_response["searchresults"]["response"]["results"]["result"] if code == 0
      return code, nil if code == 508
      return code, response.parsed_response["searchresults"]["message"]["text"]
    end

    return 500, "The server did not respond"
  end

  def self.get_search_results(address, citystatezip)
    path = "/webservice/GetSearchResults.htm"
    params = { address: address, citystatezip: citystatezip }
    params.merge!('zws-id': "X1-ZWz1dyb53fdhjf_6jziz")

    response = get("#{path}?#{Rack::Utils.build_query(params)}")
    handle_response(response)
  end

end
