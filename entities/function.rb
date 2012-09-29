module MESS
  module Entities
    class Function
      include Transformative

      def initialize(parent, entity)
        @parent = parent
        @entity = entity
      end

      def render
        func = @entity[:function].to_sym
        if [:desaturate, :saturate, :lighten, :darken, :fadein, :fadeout, :spin, :mix].include?(func)
          builtin(func)
        else
          fail "Unknown function `#{func}`."
        end
      end

      protected

      def builtin(func)
        params = @entity[:parameters]
        left = transform_entity(params[0])
        right = transform_entity(params[1])
        right = right.render if right.respond_to?(:render)
        right = right.gsub(/[^0-9]/, '').to_i

        do_operation(left, func, right)
      end
    end
  end
end
