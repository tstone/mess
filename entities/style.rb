require_relative 'block'

module MESS
  module Entities
    class Style < Block

      attr_reader :properties, :selector
      attr_writer :properties

      def initialize(parent_block, entity)
        super
        @properties = {}

        @entity = entity[:style_dec]
        transform_entities(@entity[:block])

        @selector = @entity[:selector].str
        @parent_block.add_style(@selector, self) unless @parent_block.nil?
      end

      def add_property(key, val)
        @properties[key.to_sym] = val
      end

      def render
        @css = render_properties + render_nested_styles
        @css.strip
      end

      def render_properties
        @css = ""
        if @properties.size > 0
          @css << "#{full_selector_path} {\n"
          @properties.each do |prop, instance|
            @css << instance.render + "\n"
          end
          @css << "}"
        end
        @css
      end

      def render_nested_styles
        @css = ""
        if @styles.size > 0
          @css << "\n"
          @styles.each do |style, instance|
            @css << instance.render + "\n"
          end
        end
        @css
      end

      def full_selector_path
        if @parent_block.respond_to?(:full_selector_path)
          parent_path = @parent_block.send(:full_selector_path)
          "#{parent_path} #{@selector}"
        else
          @selector
        end
      end

      def to_s
        "<Style: #@selector>"
      end
    end
  end
end
