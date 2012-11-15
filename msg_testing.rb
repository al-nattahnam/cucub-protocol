require './lib/message'
require './lib/reference'
require 'msgpack'

ref = Cucub::Reference.new({:object_uuid => 1, :class_name => "Core"})
ref2 = Cucub::Reference.new({:object_uuid => 2, :class_name => "Engine"})

puts "Message with from, to, respond_to, action, additionals params:\n"
message = Cucub::Message.new("from" => ref, "to" => ref2, "respond_to" => ref, "action" => "state", "additionals" => 1)
message.locked?
serialized = message.serialize
message.locked?

puts "==="
puts "Message by parsing serialized data:\n"
message2 = Cucub::Message.parse(serialized)
message2.locked?
message2.unlock(:msgpack)
puts "action: #{message2.action} | additionals: #{message2.additionals}"
message2.locked?
