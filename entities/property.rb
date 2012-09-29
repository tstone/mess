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

      def to_s
        "<Property: #@name>"
      end

      private

      def parse
        @name = @entity[:property]
        raw = @entity[:value]
        if raw.is_a?(Hash) then
          @value = transform_entity(raw)
        else
          @value = raw
        end

        @parent.add_property(@name, self)
      end
    end
  end
end