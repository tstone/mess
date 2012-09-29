module MESS
  module Entities
    class Block
      include Transformative

      attr_reader :variables, :styles, :mixins
      attr_writer :variables, :styles, :mixins

      def initialize(parent, entity)
        @parent = parent
        @variables = []
        @styles = []
        @mixins = []

        if entity.is_a?(Hash) and entity.has_key?(:block)
          @entity = entity[:block]
          parse
        end
      end

      private

      def parse
        transform_entities(@entity)
      end
    end
  end
end
