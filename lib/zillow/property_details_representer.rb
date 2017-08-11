# The Zillow::PropertyDetailsRepresenter parses
# a zillow prop details response onto a model object
# that supports the defined properties (or an open struct)
#
class Zillow::PropertyDetailsRepresenter < Representable::Decorator
  include Representable::JSON

  property :has_details, reader: -> (**) { true }
  property :images, parse_filter: -> (images, options) { images["image"]["url"] }
  property :description, as: :homeDescription

end
