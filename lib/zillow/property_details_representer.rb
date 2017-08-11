class Zillow::PropertyDetailsRepresenter < Representable::Decorator
  include Representable::JSON

  property :images, parse_filter: -> (images, options) { images["image"]["url"] }
  
end
