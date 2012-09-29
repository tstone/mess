require_relative 'block'

module MESS
  module Entities
    class Style < Block

      attr_reader :selector, :properties
      attr_writer :properties

      def initialize(parent, entity)
        super
        @entity = entity[:style_dec]
        @properties = {}
        parse
      end

      def add_property(key, val)
        @properties[key.to_sym] = val
      end

      def to_s
        "<Style: #@selector>"
      end

      protected

      def parse
        transform_entities(@entity[:block])
        @selector = @entity[:selector]
        @parent.add_style(@selector, self)
      end
    end
  end
end
