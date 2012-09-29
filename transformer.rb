module MESS
  module Transformative
  end

  require_relative 'entities/block.rb'
  require_relative 'entities/variable.rb'
  require_relative 'entities/style.rb'

  class Transformer
    def transform(parser_output)
      document = new Entities::Block(nil, nil)
      document.transform_entities(parser_output)
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
      self
    end

    def transform_entity(entity)
      case entity.keys[0]
      when :block then return Entities::Block(self, entity)
      when :var_def then return Entities::Variable(self, entity)
      when :style_dec then return Entities::Style(self, entity)
      #when :prop_def then return MESS::Entities::PropertyDefinition(self, entity)
      #when :mixin_definition then return MESS::Entities::MixinDefinition(self, entity)
      end
      self
    end
  end
end