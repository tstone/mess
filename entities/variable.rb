module MESS
  module Entities
    class Variable
      attr_reader :name

      def initialize(parent, entity)
        @parent = parent
        @name = entity[:var]
      end

      def render
        @parent.get_variable_value(@name)
      end

      def to_s
        "<Variable: #@name>"
      end
    end
  end
end