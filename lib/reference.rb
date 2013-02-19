module Cucub
  class Reference
    attr_reader :object_uuid # TODO rename it to uuid
    attr_reader :class_name
    attr_reader :layer
    
    def initialize(opts={})
      @object_uuid = opts["object_uuid"] || opts[:object_uuid]
      @class_name = opts["class_name"] || opts[:class_name]
      @layer = opts["layer"] || opts[:layer] || :vm # [:wcn, :server, :vm]
      @layer = @layer.to_sym
    end

    def to_hash
      output = {
        "object_uuid" => self.object_uuid,
        "class_name"  => self.class_name
      }
      output["layer"] = @layer unless @layer == :vm
      output
    end
  end
end
