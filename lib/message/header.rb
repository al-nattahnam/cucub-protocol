module Cucub
  class Message
    class Header

      attr_reader :from
      attr_reader :to
      attr_reader :respond_to
      attr_reader :uuid
      
      def initialize(opts={})
        @from = opts["from"]
        @to = opts["to"]
        @respond_to = opts["respond_to"]
        @uuid = opts["uuid"] || Cucub::Message::Header.gen_uuid(hash)
      end

      def self.gen_uuid(seed)
        uuid = seed
        uuid = -uuid if uuid < 0
        uuid.to_s(35)
      end

      def self.attrs
        [:from, :to, :respond_to, :uuid]
      end
      
      def serialize
        self.class.attrs.inject({}) { |h, attr|
          value = instance_variable_get("@#{attr}")
          if value.is_a? Cucub::Reference
            h[attr] = value.to_hash
          elsif value.is_a? String
            h[attr] = value
          end
          h
        }
      end

      def self.parse(hash)
        # It may not receive a respond_to in case of sending: registrations (from VM to Server); ready jobs (from VM to Server)..
        respond_to = Cucub::Reference.new(hash["respond_to"]) rescue nil
        Cucub::Message::Header.new(
          "from" => Cucub::Reference.new(hash["from"]),
          "to" => Cucub::Reference.new(hash["to"]),
          "respond_to" => respond_to,
          "uuid" => hash["uuid"]
        )
      end

    end
  end
end
