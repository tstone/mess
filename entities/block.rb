module MESS
  module Entities
    class Block
      include Transformative

      def initialize(parent, entity)
        @parent = parent
      end
    end
  end
end
