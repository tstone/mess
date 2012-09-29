module MESS
  module Transformative; end

  require_relative 'entities/block.rb'
  require_relative 'entities/variable.rb'
  require_relative 'entities/style.rb'
  require_relative 'entities/expression.rb'

  class Transformer
    def transform(parser_output)
      document = Entities::Block.new(nil, nil)
      document.transform_entities(parser_output)
      document
    end
  end

  module Transformative
    def transform_entities(entities)
      if entities.kind_of?(Array)
        entities.each do |e|
          transform_entity(e)
        end
      else
        transform_entity(entities)
      end
    end

    def transform_entity(entity)
      case entity.keys[0]
      when :block then return Entities::Block.new(self, entity)
      when :var_def then return Entities::Variable.new(self, entity)
      when :style_dec then return Entities::Style.new(self, entity)
      when :expression then return Entities::Expression.new(self, entity)
      #when :prop_def then return MESS::Entities::PropertyDefinition(self, entity)
      #when :mixin_definition then return MESS::Entities::MixinDefinition(self, entity)
      else
        puts "Entity type not setup for '#{entity.keys[0]}'"
      end
    end
  end
end