class Zillow::PropertyDetailsRepresenter < Representable::Decorator
  include Representable::JSON

  property :has_details, reader: -> (**) { true }
  property :images, parse_filter: -> (images, options) { images["image"]["url"] }
  property :description, as: :homeDescription

end
