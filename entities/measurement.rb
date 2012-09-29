module MESS
  module Entities
    class Measurement
      attr_reader :type

      def initialize(parent, entity)
        @parent = parent
        @entity = entity[:measurement]
        @type = @entity.keys[0]
        @value = @entity[@type]
      end

      def render
        "#@value#{@type.to_s}"
      end

      def to_s
        "<Measurement: #@type>"
      end
    end
  end
end