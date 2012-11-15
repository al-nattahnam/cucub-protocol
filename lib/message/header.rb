module Cucub
  class Message
    class Header

      attr_reader :from
      attr_reader :to
      attr_reader :respond_to
      
      def initialize(opts={})
        @from = opts["from"]
        @to = opts["to"]
        @respond_to = opts["respond_to"]
      end

      def self.attrs
        [:from, :to, :respond_to]
      end
      
      def serialize
        self.class.attrs.inject({}) { |h, attr|
          value = instance_variable_get("@#{attr}")
          if value.is_a? Cucub::Reference
            h[attr] = value.to_hash
          elsif attr.is_a? String
            h[attr] = value
          end
          h
        }
      end

      def self.parse(hash)
        Cucub::Message::Header.new(
          "from" => Cucub::Reference.new(hash["from"]),
          "to" => Cucub::Reference.new(hash["to"]),
          "respond_to" => Cucub::Reference.new(hash["respond_to"])
        )
      end

    end
  end
end
