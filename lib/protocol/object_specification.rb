module Cucub
  module Protocol
    class ObjectSpecification < Specification
      attr_reader :role
      
      def initialize(class_name)
        @class_name = class_name

        @role = :both # both receiver emitter
        
        super()
      end

      def role=(role)
        role = role.to_sym
        raise "invalid role!" if ![:both, :receiver, :emitter].include?(role)
        @role = role
      end

    end
  end
end
