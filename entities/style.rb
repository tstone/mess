require_relative 'block'

module MESS
  module Entities
    class Style < Block

      attr_reader :properties
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

      def space_depth
        @parent.space_depth + 4
      end

      def full_selector
        sel = ""
        sel = @parent.selector unless @parent.selector.nil?
        sel << " #@selector"
        sel.strip
      end

      def render
        @css = "#{full_selector} {\n"

        # Properties
        @properties.each do |prop, instance|
          @css << instance.render(space_depth) + "\n"
        end

        # Nested styles
        if (@styles.size > 0) then
          @css << "\n"
          @styles.each do |style, instance|
            @css << instance.render(space_depth) + "\n"
          end
        end

        @css << "}"
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
