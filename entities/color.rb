require 'color'

module MESS
  module Entities
    class ColorExpr
      def initialize(parent, entity)
        @parent = parent
        @entity = entity[:color]
        @format = @entity.keys[0]
        translate
      end

      def render
        case @format
        when :hex_color then render_hex
        when :rgb_color then render_rgb
        when :hsl_color then render_hsl
        when :hsla_color then render_hsla
        end
      end

      def operate(operator, right_hand)
        # Assume integer for now
        mod = right_hand.to_i
        op = operator.to_sym

        @color.red = @color.red.send(op, mod)
        @color.green = @color.green.send(op, mod)
        @color.blue = @color.blue.send(op, mod)

        render
      end

      private

      def translate
        @a = 1
        @color = case @format
        when :hex_color then Color::RGB.from_html(@entity[:hex_color].str)
        when :rgb_color then
          rgb = @entity[:rgb_color]
          Color::RGB.new(rgb[:r].to_i, rgb[:g].to_i, rgb[:b].to_i)
        when :rgba_color then
          rgb = @entity[:rgb_color]
          @a = rgb[:a]
          Color::RGB.new(rgb[:r].to_i, rgb[:g].to_i, rgb[:b].to_i)
        when :hsl_color then render_hsl
          hsl = @entity[:hsl_color]
          Color::HSL.new(hsl[:h].to_i, hsl[:s].to_i, hsl[:l].to_i).to_rgb
        when :hsla_color then render_hsla
          hsl = @entity[:hsl_color]
          @a = hsl[:a]
          Color::HSL.new(hsl[:h].to_i, hsl[:s].to_i, hsl[:l].to_i).to_rgb
        end
      end

      def render_hex
        @color.html
      end

      def render_rgb
        "rgb(#{@color.red}, #{@color.green}, #{@color.blue})"
      end

      def render_rgba
        "rgb(#{@color.red}, #{@color.green}, #{@color.blue}, #{@a})"
      end

      def render_hsl
        hsl = @color.to_hsl
        "hsl(#{hsl.hue}, #{hsl.saturation}, #{hsl.lightness})"
      end

      def render_hsla
        hsl = @color.to_hsl
        "hsla(#{hsl.hue}, #{hsl.saturation}, #{hsl.lightness}, #{@a})"
      end
    end
  end
end