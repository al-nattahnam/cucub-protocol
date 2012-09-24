module Cucub
  module Protocol
    class SpecificationSet
      def initialize
        @object_specifications = []
      end

      def add_object_specification(obj_spec)
        @object_specifications.push obj_spec
      end

      def object_specifications
        @object_specifications
      end

      def [](class_name)
        # TODO there should be a method to facilitate search in to spec_set for a class
        object_specification = @object_specifications.select {|spec| spec.class_name == class_name }.first

        if object_specification
          return object_specification
        else
          raise "class was not defined!"
        end
      end
    end
  end
end
