module MESS
  module Entities
    class Expression
      include Transformative

      def initialize(parent, entity)
        @parent = parent
        @entity = entity[:expression]
      end

      def render
        unless @entity.has_key?(:operator)
          entity(@entity[:left_hand])
        else
          # TODO
        end
      end

      private

      def entity(e)
        ent = transform_entity(e)

        puts "\nent:\n#{ent}\n\n"

        if ent.respond_to?(:render)
          ent.render
        else
          ent
        end
      end

      def operator
      end

      def builtin_function
      end

    end
  end
end
