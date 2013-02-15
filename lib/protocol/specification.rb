require_relative './policies/respond_to'

module Cucub
  module Protocol
    class Specification
      
      def initialize
      end

      def uses_box=(uses_box)
        if uses_box.is_a?(TrueClass) || uses_box.is_a?(FalseClass)
          @uses_box = uses_box
        elsif uses_box.is_a? String
          case uses_box
            when "true"
              @uses_box = true
            when "false"
              @uses_box = false
            else
              raise "invalid value for uses_box!"
          end
        else
          raise "invalid value for uses_box!"
        end
      end

      def uses_mailbox=(uses_mailbox)
        if uses_mailbox.is_a?(TrueClass) || uses_mailbox.is_a?(FalseClass)
          @uses_mailbox = uses_mailbox
        elsif uses_mailbox.is_a? String
          case uses_mailbox
            when "true"
              @uses_mailbox = true
            when "false"
              @uses_mailbox = false
            else
              raise "invalid value for uses_mailbox!"
          end
        else
          raise "invalid value for uses_mailbox!"
        end
      end

      def uses_board=(uses_board)
        if uses_board.is_a?(TrueClass) || uses_board.is_a?(FalseClass)
          @uses_board = uses_board
        elsif uses_board.is_a? String
          case uses_board
            when "true"
              @uses_board = true
            when "false"
              @uses_board = false
            else
              raise "invalid value for uses_board!"
          end
        else
          raise "invalid value for uses_board!"
        end
      end

      def respond_to=(respond_to)
        @respond_to = Cucub::Protocol::Policies::RespondTo.parse(respond_to)
      end

      def serialize=(serialization)
        serialization = serialization.to_sym
        raise "invalid serialization type!" if ![:none, :msgpack].include?(serialization)
        @serialize = serialization
      end

      def compression=(compression)
        compression = compression.to_sym
        raise "invalid compression type!" if ![:none, :gzip].include?(compression)
        @compression = compression
      end

      def encryption=(encryption)
        encryption = encryption.to_sym
        raise "invalid encryption type!" if ![:none].include?(encryption)
        @encryption = encryption
      end

    end
  end
end
