module MESS
  module Entities
    class Block
      include Transformative

      attr_reader :selector, :variables, :styles, :mixins
      attr_writer :variables, :styles, :mixins

      def initialize(parent, entity)
        @parent = parent
        @selector = ""
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

      def space_depth
        0
      end

      def get_variable_def(key)
        var = @variables[key.to_sym]
        if var.nil?
          if @parent.nil?
            fail "Variable `#{key}` not defined."
          else
            @parent.get_variable_def(key)
          end
        else
          var
        end
      end

      def get_variable_value(key)
        get_variable_def(key).render
      end
    end
  end
end
