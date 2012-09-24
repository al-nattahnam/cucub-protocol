module Cucub
  module Protocol
    class ObjectSpecification < Specification
      attr_reader :class_name
      attr_reader :role
      
      def initialize(class_name)
        @class_name = class_name

        @role = :both # both receiver emitter

        @action_specifications = []
        
        super()
      end

      def role=(role)
        role = role.to_sym
        raise "invalid role!" if ![:both, :receiver, :emitter].include?(role)
        @role = role
      end
      
      def uses_box
        @uses_box || false
      end

      def uses_mailbox
        @uses_mailbox || false
      end

      def uses_board
        @uses_board || false
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
