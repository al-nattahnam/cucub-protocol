module Cucub
  module Protocol
    class ActionSpecification < Specification
      attr_reader :class_name, :action_name
      attr_reader :from, :respond_to, :read_by

      def initialize(class_name, action_name)
        @class_name = class_name
        @action_name = action_name

        super()
      end

      def object_specification
        Cucub::Protocol::Loader.instance.specifications[@class_name]
      end

      def from=(from)
        @from = from
      end

      def respond_to=(respond_to)
        @respond_to = respond_to
      end

      def read_by=(read_by)
        @read_by = read_by
      end
      
      def uses_box
        @uses_box || object_specification.has_default?(:box)
      end

      def uses_mailbox
        @uses_mailbox || object_specification.has_default?(:mailbox)
      end

      def uses_board
        @uses_board || object_specification.has_default?(:board)
      end

      def serialize
        @serialize || object_specification.serialize
      end

      def compression
        @compression || :none # gzip
      end
      
      def encryption
        @encryption || :none #
      end

    end
  end
end
