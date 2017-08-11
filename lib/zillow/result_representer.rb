class Zillow::ResultRepresenter < Representable::Decorator
  include Representable::JSON

  property :provider, reader: -> (**) { "zillow" }
  property :provider_id, as: :zpid
  property :links
  property :address
  property :estimate, as: :zestimate
  property :local_info, as: :localRealEstate

end
