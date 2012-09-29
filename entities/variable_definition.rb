module MESS
  module Entities
    class VariableDefinition
      include Transformative

      attr_reader :name, :value

      def initialize(parent, entity)
        @parent = parent
        @entity = entity[:var_def]
        @name = @entity[:var]
        @value = Entities::Expression.new(self, @entity)
        @parent.add_variable(@name, self)
      end

      def render
        if @value.respond_to?(:render)
          @value.render
        else
          @value
        end
      end

      def to_s
        "<Variable Definition: #@name>"
      end
    end
  end
end