module MESS
  module Entities
    class Property
      include Transformative

      attr_reader :name, :value

      def initialize(parent, entity)
        @parent = parent
        @entity = entity[:prop_def]
        parent.properties << self
        parse
      end

      def to_s
        "<Property: #@name>"
      end

      private

      def parse
        @name = @entity[:property]
        @raw_value = @entity[:value]
        if @raw_value.is_a?(Hash) then
          @value = transform_entity(@raw_value)
        else
          @value = @raw_value
        end
      end
    end
  end
end