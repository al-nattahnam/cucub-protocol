# Casos de uso
#* normal serialization is done with msgpack
#1) Create message with not serialized data: Header + Body.
#      => Message.new(from, to, respond_to, action, additionals)
#       > Message.header = Header
#       > Message.body = Body (with attrs loaded, not crypted, not normally serialized)
#2) Serialize message: returns the serialized message, and sets the serialization flags on the Message instance.
#3) Create message with normally serialized data:
#      => Message.parse(msg)
#       > Message.header = Header
#       > Message.body = Body (without attrs loaded, crypted/serialized string)
#

require_relative './message/header'
require_relative './message/body'

module Cucub
  class Message

    attr_reader :header
    attr_reader :body

    def initialize(opts={})
      if opts.has_key?("header") && opts.has_key?("body")
        @header = Cucub::Message::Header.parse(opts["header"])
        @body = Cucub::Message::Body.load(opts["body"])
      else
        opts_for_header = opts.select{|key| ["from", "to", "respond_to", "layer"].include?(key)}
        @header = Cucub::Message::Header.new(opts_for_header)
        @body = Cucub::Message::Body.new(opts["action"], opts["additionals"])
      end
    end

    def serialize
      {
        :header => @header.serialize,
        :body => @body.serialize!
      }.to_msgpack
    end

    def locked?
      @body.locked?
    end

    def unlock(mechanism)
      @body.unlock(mechanism)
    end

    def action
      @body.action
    end

    def additionals
      @body.additionals
    end

    def self.parse(msg)
      hash = MessagePack.unpack(msg)
      message = Cucub::Message.new(hash)
    end

    def self.decode(msg)
      decoded = MessagePack.unpack(msg)
      return Cucub::Message.new(decoded["agent"], decoded["id"], decoded["body"])
    end
  end
end
