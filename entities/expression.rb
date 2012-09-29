module MESS
  module Entities
    class Expression
      include Transformative

      def initialize(parent, entity)
        @parent = parent
        @entity = entity
      end

      def realize
      end

      private

      def operator
      end

      def builtin_function
      end

    end
  end
end
