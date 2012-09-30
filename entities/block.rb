module MESS
  module Entities
    class Block
      include Transformative

      attr_reader :seletor, :variables, :styles, :mixins
      attr_writer :variables, :styles, :mixins

      def initialize(parent_block, entity)
        @parent_block = parent_block
        @variables = {}
        @styles = []
        @mixins = {}
      end

      def add_style(key, val)
        @styles << val
      end

      def add_variable(key, val)
        @variables[key.to_sym] = val
      end

      def add_mixin(key, val)
        @mixins[key.to_sym] = val
      end

      def get_variable_def(key)
        var = @variables[key.to_sym]
        if var.nil?
          if @parent_block.nil?
            fail "Variable `#{key}` not defined."
          else
            @parent_block.get_variable_def(key)
          end
        else
          var
        end
      end

      def get_variable_value(key)
        get_variable_def(key).render
      end

      def to_s
        return "<Root>" if @parent_block == nil
        "<Block: #{@selector}>"
      end
    end
  end
end
