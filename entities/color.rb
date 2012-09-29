module MESS
  module Entities
    class Color
      def initialize(parent, entity)
        @parent = parent
        @entity = entity[:color]
      end

      def render
        case @entity.keys[0]
        when :hex_color then render_hex
        when :rgb_color then render_rgb
        when :hsl_color then render_hsl
        when :hsla_color then render_hsla
        end
      end

      def operate(operator, right_hand)
        puts "OPERATE ON COLOR (TODO)"
      end

      private

      def render_hex
        @entity[:hex_color]
      end

      def render_rgb
        rgb = @entity[:rgb_color]
        r = rgb[:r]
        g = rgb[:g]
        b = rgb[:b]
        "rgb(#{r},#{g},#{b})"
      end

      def render_rgba
        rgba = @entity[:rgba_color]
        r = rgb[:r]
        g = rgb[:g]
        b = rgb[:b]
        a = rgb[:a]
        "rgb(#{r},#{g},#{b},#{a})"
      end

      def render_hsl
        fail "HSL rendering not yet implemented"
      end

      def render_hsla
        fail "HSLA rendering not yet implemented"
      end
    end
  end
end