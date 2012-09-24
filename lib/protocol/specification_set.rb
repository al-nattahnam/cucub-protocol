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
    end
  end
end
