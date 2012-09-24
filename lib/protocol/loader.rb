module Cucub
  module Protocol
    class Loader
      def initialize(filepath)
        @filepath = filepath
      end

      def parse
        basefile = IniFile.load(@filepath)
        
        current_specifications = Cucub::Protocol::SpecificationSet.new

        basefile.sections.reject { |x| x.include?("#") }.each { |section|
          object_spec = parse_object_specification(section, basefile[section])
          current_specifications.add_object_specification(object_spec)
        }
        
        current_specifications
      end

      def parse_object_specification(class_name, section)
        object_specification = Cucub::Protocol::ObjectSpecification.new(class_name)

        section.each_pair { |key, value|
          object_specification.send("#{key}=".to_sym, value)
        }
        object_specification
      end
    end
  end
end
