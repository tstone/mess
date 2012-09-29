module MESS
  module Transformative; end

  require_relative 'transformative'
  require_relative 'entities/block.rb'
  require_relative 'entities/variable_definition.rb'
  require_relative 'entities/variable.rb'
  require_relative 'entities/style.rb'
  require_relative 'entities/expression.rb'
  require_relative 'entities/property.rb'
  require_relative 'entities/color.rb'
  require_relative 'entities/measurement.rb'

  class Transformer
    def transform(parser_output)
      document = Entities::Block.new(nil, nil)
      document.transform_entities(parser_output)
      document
    end
  end
end