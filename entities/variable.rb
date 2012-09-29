module MESS
  module Entities
    class Variable
      include Transformative

      attr_reader :name, :value

      def initialize(parent, entity)
        @parent = parent
        @entity = entity[:var_def]
        parse
      end

      def to_s
        "<Variable: #@name>"
      end

      private

      def parse
        @name = @entity[:var]
        raw = @entity[:value]
        if raw.is_a?(Hash) then
          @value = transform_entity(raw)
        else
          @value = raw
        end

        @parent.add_variable(@name, self)
      end
    end
  end
end