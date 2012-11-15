module Cucub
  class Message
    class Body  

      attr_reader :action
      attr_reader :additionals

      def initialize(action=nil, additionals=nil, serialized=nil)
        @action = action
        @additionals = additionals
        @serialized = serialized
      end

      def self.attrs
        [:action, :additionals]
      end

      def lock(&block)
        puts "Locking..."
        yield
        @action = nil
        @additionals = nil
      end

      def locked?
        puts "Locked?: #{!(@serialized == nil)}"
        !(@serialized == nil)
      end

      def serialize!
        return @serialized unless @serialized == nil
        lock {
          @serialized = self.class.attrs.inject({}) { |h, attr|
            value = instance_variable_get("@#{attr}")
            h[attr] = value
            h
          }.to_msgpack
        }
        return @serialized
      end

      def self.load(body)
        body = Cucub::Message::Body.new(nil, nil, body)
      end

      #def self.decode(serialized, decode_params={})
      #  decoded = MessagePack.unpack(msg)
      #  return Cucub::Body.new(decoded["action"], decoded["additionals"])
      #end

      def unlock(mechanism)
        return false if not locked?
        puts "Unlocking..."
        case mechanism
          when :msgpack
            decoded = MessagePack.unpack(@serialized)
            @action = decoded["action"]
            @additionals = decoded["additionals"]
            @serialized = nil
        end
      end

    end
  end
end
