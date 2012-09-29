module MESS
  module Entities
    class VariableDefinition
      include Transformative

      attr_reader :name, :value

      def initialize(parent, entity)
        @parent = parent
        @entity = entity[:var_def]
        parse
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

      private

      def parse
        @name = @entity[:var]
        raw = @entity[:value]
        if raw.is_a?(Hash) then
          @value = transform_entity(raw)
        else
          @value = raw
        end

        @parent.add_variable(@name, self)
      end
    end
  end
end