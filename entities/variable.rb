module MESS
  module Entities
    class Variable
      include Transformative

      attr_reader :name

      def initialize(parent, entity)
        @parent = parent
        @name = entity[:var]
      end

      def render
        @parent.get_variable_value(@name)
      end

      def operate(operator, right_hand)
        var = @parent.get_variable_def(@name)
        do_operation(var.value, operator, right_hand)
      end

      def to_s
        render
      end
    end
  end
end