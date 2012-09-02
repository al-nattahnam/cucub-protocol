module Cucub
  class Message
    attr_reader :id
    attr_reader :body

    def initialize(agent, id, body)
      @id = id
      @body = body
    end

    def self.encode(agent, id, body)
      {
        "id" => id,
        "body" => body
      }.to_msgpack
    end

    def self.decode(msg)
      decoded = MessagePack.unpack(msg)
      return Cucub::Message.new(decoded["id"], decoded["body"])
    end
  end
end
