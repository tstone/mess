module MESS
  module Entities
    class Block
      include Transformative

      attr_reader :variables, :styles, :mixins
      attr_writer :variables, :styles, :mixins

      def initialize(parent, entity)
        @parent = parent
        @variables = {}
        @styles = {}
        @mixins = {}
      end

      def add_style(key, val)
        @styles[key.to_sym] = val
      end

      def add_variable(key, val)
        @variables[key.to_sym] = val
      end

      def add_mixin(key, val)
        @mixins[key.to_sym] = val
      end
    end
  end
end
