class HomeRepresenter < Representable::Decorator
  include Representable::JSON

  property :provider
  property :provider_id
  property :links
  property :address
  property :estimate

end
