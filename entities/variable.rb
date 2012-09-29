module MESS
  module Entities
    class Variable
      include Transformative

      attr_reader :name, :raw_value, :value

      def initialize(parent, entity)
        @parent = parent
        @entity = entity[:var_def]
        parent.variables << self
        parse
      end

      def to_s
        "<Variable: #@name>"
      end

      private

      def parse
        @name = @entity[:var]
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