module MESS
  module Entities
    class Property
      include Transformative

      attr_reader :name, :value

      def initialize(parent, entity)
        @parent = parent
        @entity = entity[:prop_def]
        parse
      end

      def render(space_depth)
        val = if @value.respond_to?(:render)
          @value.render
        else
          @value
        end

        (" " * space_depth) + "#@name: #{val};"
      end

      def to_s
        "<Property: #@name>"
      end

      private

      def parse
        @name = @entity[:property]
        @value = if @entity[:value].is_a?(Hash) then
          transform_entity(@entity[:value])
        else
          @entity[:value]
        end

        @parent.add_property(@name, self)
      end
    end
  end
end