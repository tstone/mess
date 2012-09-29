module MESS
  module Transformative; end

  require_relative 'transformative'
  require_relative 'entities/block'
  require_relative 'entities/variable_definition'
  require_relative 'entities/variable'
  require_relative 'entities/style'
  require_relative 'entities/expression'
  require_relative 'entities/property'
  require_relative 'entities/color'
  require_relative 'entities/measurement'
  require_relative 'entities/function'

  class Transformer
    def transform(parser_output)
      document = Entities::Block.new(nil, nil)
      document.transform_entities(parser_output)
      document
    end
  end
end