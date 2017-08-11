# the Zillow::ResultRepresenter parses
# a zillow search results onto a model object
# that supports the defined properties (or an open struct)
#
# zestimates are parsed to money objects for easy
# manipulation in the app / ui
# https://github.com/RubyMoney/money
#
class Zillow::ResultRepresenter < Representable::Decorator
  include Representable::JSON

  property :provider, reader: -> (**) { "zillow" }
  property :provider_id, as: :zpid
  property :links
  property :address
  property :estimate, as: :zestimate, parse_filter: -> (estimate, options) {
    hsh = {}
    hsh["amount"] = Money.from_amount(estimate["amount"]["__content__"].to_i, estimate["amount"]["currency"])
    hsh["value_change"] = {
      "amount" => Money.from_amount(estimate["valueChange"]["__content__"].to_i, estimate["valueChange"]["currency"]),
      "in_last" => estimate["valueChange"]["duration"]
    }

    hsh["range"] = {
      "low_amount" => Money.from_amount(estimate["valuationRange"]["low"]["__content__"].to_i, estimate["valuationRange"]["low"]["currency"]),
      "high_amount" => Money.from_amount(estimate["valuationRange"]["high"]["__content__"].to_i, estimate["valuationRange"]["high"]["currency"])
    }
    return hsh
  }

  property :local_info, as: :localRealEstate, parse_filter: -> (local_info, options) {
    hsh = {}
    hsh["name"] = local_info["region"]["name"]
    hsh["average_amount"] = local_info["region"]["zindexValue"]
    return hsh
  }

  property :use_code, as: :useCode
  property :bedrooms
  property :bathrooms
  property :square_feet, as: :finishedSqFt

end
