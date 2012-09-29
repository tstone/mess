module MESS
  module Entities
    class Block
      include Transformative

      attr_reader :variables, :styles, :mixins
      attr_writer :variables, :styles, :mixins

      def initialize(parent, entity)
        @parent = parent
        @variables = []
        @styles = []
        @mixins = []
      end
    end
  end
end
