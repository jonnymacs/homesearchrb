require 'httparty'
require 'rack'

class Zillow
  include HTTParty
  base_uri 'http://www.zillow.com'
  format :xml

  def self.get_search_results(address, citystatezip)
    path = "/webservice/GetSearchResults.htm"
    params = { address: address, citystatezip: citystatezip }
    params.merge!('zws-id': "X1-ZWz1dyb53fdhjf_6jziz")

    # headers = { "Accept" => "*/*",
    #             "Accept-Encoding" => "gzip,deflate,sdch",
    #             "Accept-Language" => "en-US,en;q=0.8" }

    p Rack::Utils.build_query(params)
    get("#{path}?#{Rack::Utils.build_query(params)}")
  end

end
