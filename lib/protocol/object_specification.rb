module Cucub
  module Protocol
    class ObjectSpecification < Specification
      attr_reader :class_name
      attr_reader :role
      
      def initialize(class_name)
        @class_name = class_name

        @role = :both # both receiver emitter

        @action_specifications = []

        @uses = :box
        
        super()
      end

      def role=(role)
        role = role.to_sym
        raise "invalid role!" if ![:both, :receiver, :emitter].include?(role)
        @role = role
      end

      def default_uses=(uses)
        uses = uses.to_sym
        raise "invalid uses type!" if ![:box, :board, :mailbox].include?(uses)
        @uses = uses
      end

      def has_default?(uses)
        @uses == uses
      end
      
      def uses_box
        @action_specifications.select(&:uses_box).size > 0
      end

      def uses_mailbox
        @action_specifications.select(&:uses_mailbox).size > 0
      end

      def uses_board
        @action_specifications.select(&:uses_board).size > 0
      end

      def serialize
        @serialize || :none # msgpack
      end

      def compression
        @compression || :none # gzip
      end
      
      def encryption
        @encryption || :none #
      end

      def add_action_specification(action_spec)
        @action_specifications.push action_spec
      end

      def action_specifications
        @action_specifications
      end

    end
  end
end
