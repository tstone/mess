module MESS
  module Entities
    class Style
      include Transformative

      attr_reader :selector, :properties
      attr_writer :properties

      def initialize(parent, entity)
        @parent = parent
        @entity = entity[:style_dec]
        @properties = []
        parent.styles << self
        parse
      end

      def to_s
        "<Style: #@selector>"
      end

      private

      def parse
        @selector = @entity[:selector]
        transform_entities(@entity[:block])
      end
    end
  end
end