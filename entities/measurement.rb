module MESS
  module Entities
    class Measurement
      include Transformative

      attr_reader :type

      def initialize(parent, entity)
        @parent = parent
        @entity = entity[:measurement]
        @type = @entity.keys[0]
        @value = @entity[@type]
      end

      def operate(operator, right_hand)
        val = do_operation(@value.to_i, operator, right_hand)
        render(val)
      end

      def render(value = @value)
        "#{value}#{@type.to_s}"
      end

      def to_s
        "<Measurement: #@type>"
      end
    end
  end
end