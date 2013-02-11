module Cucub
  class Reference
    attr_reader :object_uuid
    attr_reader :class_name
    
    def initialize(opts={})
      @object_uuid = opts["object_uuid"] || opts[:object_uuid]
      @class_name = opts["class_name"] || opts[:class_name]
    end

    def to_hash
      {
        "object_uuid" => self.object_uuid,
        "class_name"  => self.class_name
      }
    end
  end
end
