module MESS
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
      when :var_def then return Entities::VariableDefinition.new(self, entity)
      when :var then return Entities::Variable.new(self, entity)
      when :style_dec then return Entities::Style.new(self, entity)
      when :expression then return Entities::Expression.new(self, entity)
      when :prop_def then return Entities::Property.new(self, entity)
      when :color then return Entities::ColorExpr.new(self, entity)
      when :measurement then return Entities::Measurement.new(self, entity)
      #when :mixin_definition then return MESS::Entities::MixinDefinition(self, entity)
      else
        puts "Entity type not setup for '#{entity.keys[0]}'"
      end
    end

    def get_variable_def(key)
      @parent.get_variable_def(key)
    end

    def get_variable_value(key)
      @parent.get_variable_value(key)
    end

    protected

    def do_operation(left, operator, right)
      if left.respond_to?(:operate)
        left.operate(operator, right)
      else
        # Assume it's just a numeric operation
        begin
          left.to_i.send(operator.to_sym, right.render.to_i)
        rescue
          fail "#{left} does not support the `#{operator}` operation."
        end
      end
    end
  end
end