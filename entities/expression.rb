module MESS
  module Entities
    class Expression
      include Transformative

      def initialize(parent, entity)
        @parent = parent
        @entity = entity[:expression]
      end

      def render
        render_unknown_entity(@entity)
      end

      def operate(operator, right_hand)
        left = transform_entity(@entity)
        do_operation(left, operator, right_hand)
      end

      private

      def render_unknown_entity(entity)
        if entity.is_a?(Hash)
          render_hash(entity)
        elsif entity.respond_to?(:render)
          entity.render
        else
          entity.to_s
        end
      end

      def render_hash(entity)
        if entity.has_key?(:operation)
          do_operator(entity)
        elsif entity.has_key?(:builtin_func)
          do_builtin_function(entity)
        else
          entity = transform_entity(entity)
          render_unknown_entity(entity)
        end
      end

      def do_operator(entity)
        left_entity = entity.dup.reject!{ |k| k == :operation }
        left_hand = transform_entity(left_entity)

        operator = entity[:operation][:operator]

        right_entity = entity[:operation][:right_hand]
        right_hand = if right_entity.is_a?(Hash)
          transform_entity(right_entity)
        else
          right_entity
        end

        if left_hand.respond_to?(:operate)
          left_hand.operate(operator.to_sym, right_hand)
        else
          fail "#{left_hand} does not support the `#{operator}` operation."
        end
      end
    end
  end
end
