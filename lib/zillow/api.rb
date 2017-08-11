# The Zillow::Api class offers static class methods
# to interface with the zillow xml api
# https://www.zillow.com/howto/api/APIOverview.htm
#
# this Api returns a tuple of (status, response)
# zillow status is parsed from the response message code

module Zillow
  class Api
    include HTTParty
    ZWS_ID = "X1-ZWz1dyb53fdhjf_6jziz" #ideally this is in an encrypted config file
    base_uri 'http://www.zillow.com'
    format :xml

    def self.handle_search_response(response)
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

    # this is so similar to handle_search_response...
    # opportunitiy to dry it up
    #
    def self.handle_details_response(response)
      # api returns 200 even on failure...
      if response.code == 200
        # check the real response code...
        code = response.parsed_response["updatedPropertyDetails"]["message"]["code"].to_i
        return 200, response.parsed_response["updatedPropertyDetails"]["response"] if code == 0
        return code, nil if code == 508
        return code, response.parsed_response["updatedPropertyDetails"]["message"]["text"]
      end

      return 500, "The server did not respond"
    end

    def self.get_path(method)
      endpoint = method.to_s.split("_").map(&:capitalize).join
      return "/webservice/#{endpoint}.htm"
    end

    # get deep search results
    # https://www.zillow.com/howto/api/GetDeepSearchResults.htm
    #
    def self.get_deep_search_results(address, citystatezip)
      path = get_path(__method__)

      params = { address: address, citystatezip: citystatezip }
      params.merge!('zws-id': ZWS_ID)

      response = get("#{path}?#{Rack::Utils.build_query(params)}")
      handle_search_response(response)
    end

    # get property details by zpid
    # https://www.zillow.com/howto/api/GetUpdatedPropertyDetails.htm
    #
    def self.get_updated_property_details(zpid)
      path = get_path(__method__)

      params = { zpid: zpid }
      params.merge!('zws-id': ZWS_ID)

      response = get("#{path}?#{Rack::Utils.build_query(params)}")
      handle_details_response(response)
    end

  end
end
