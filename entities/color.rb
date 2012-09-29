require 'color'

module MESS
  module Entities
    class ColorExpr
      attr_reader :color, :format, :alpha

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

      def operate(operator, right)

        puts "\n\nColorExpr operate, right: #{right}\n\n"
        op = operator.to_sym
        r_delta = 0
        g_delta = 0
        b_delta = 0

        if right.respond_to?(:color)
          r_delta = right.color.red
          g_delta = right.color.green
          b_delta = right.color.blue
        else
          r_delta = g_delta = b_delta = right.to_i
        end

        # TODO: This mutates the color.  Is that right or wrong?

        @color.red = @color.red.send(op, r_delta)
        @color.green = @color.green.send(op, g_delta)
        @color.blue = @color.blue.send(op, b_delta)

        render
      end

      private

      def translate
        @alpha = 1
        @color = case @format
        when :hex_color then Color::RGB.from_html(@entity[:hex_color].str)
        when :rgb_color then
          rgb = @entity[:rgb_color]
          Color::RGB.new(rgb[:r].to_i, rgb[:g].to_i, rgb[:b].to_i)
        when :rgba_color then
          rgb = @entity[:rgb_color]
          @alpha = rgb[:a]
          Color::RGB.new(rgb[:r].to_i, rgb[:g].to_i, rgb[:b].to_i)
        when :hsl_color then render_hsl
          hsl = @entity[:hsl_color]
          Color::HSL.new(hsl[:h].to_i, hsl[:s].to_i, hsl[:l].to_i).to_rgb
        when :hsla_color then render_hsla
          hsl = @entity[:hsl_color]
          @alpha = hsl[:a]
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
        "rgb(#{@color.red}, #{@color.green}, #{@color.blue}, #{@alpha})"
      end

      def render_hsl
        hsl = @color.to_hsl
        "hsl(#{hsl.hue}, #{hsl.saturation}, #{hsl.lightness})"
      end

      def render_hsla
        hsl = @color.to_hsl
        "hsla(#{hsl.hue}, #{hsl.saturation}, #{hsl.lightness}, #{@alpha})"
      end
    end
  end
end