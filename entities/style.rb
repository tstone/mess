module MESS
  module Entities
    class Style

      attr_reader :selector, :block

      def initialize(parent, entity)
        @parent = parent
        @entity = entity[:style_dec]
        parent.styles << self
        parse
      end

      def to_s
        "<Style: #@selector>"
      end

      private

      def parse
        @selector = @entity[:selector]
        @block = @entity[:block]
      end
    end
  end
end