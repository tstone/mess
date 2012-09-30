module MESS
  module Entities
    class Property
      include Transformative

      attr_reader :name, :value

      def initialize(parent, entity)
        @parent = parent
        @entity = entity[:prop_def]
        @name = @entity[:property]
        @value = Entities::Expression.new(self, @entity)
        @parent.add_property(@name, self)
      end

      def render
        val = if @value.respond_to?(:render)
          @value.render
        else
          @value
        end

        "  #@name: #{val};"
      end

      def to_s
        "<Property: #@name>"
      end
    end
  end
end