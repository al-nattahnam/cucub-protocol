require 'singleton'

module Cucub
  module Protocol
    class Loader
      include Singleton
      
      def set_path(filepath)
        @filepath = filepath
      end

      def specifications
        @current_specifications
      end

      def parse
        basefile = IniFile.load(@filepath)
        
        current_specifications = Cucub::Protocol::SpecificationSet.new

        basefile.sections.reject { |x| x.include?("#") }.each { |section|
          object_spec = parse_object_specification(section, basefile[section])
          current_specifications.add_object_specification(object_spec)
        }

        basefile.sections.select { |x| x.include?("#") }.each { |section|
          class_name, action_name = section.split("#")
          action_spec = parse_action_specification(class_name, action_name, basefile[section])
          current_specifications[class_name].add_action_specification(action_spec)
        }
        
        @current_specifications = current_specifications
      end

      def parse_object_specification(class_name, section)
        object_specification = Cucub::Protocol::ObjectSpecification.new(class_name)

        section.each_pair { |key, value|
          object_specification.send("#{key}=".to_sym, value)
        }
        object_specification
      end

      def parse_action_specification(class_name, action_name, section)
        action_specification = Cucub::Protocol::ActionSpecification.new(class_name, action_name)

        section.each_pair { |key, value|
          action_specification.send("#{key}=".to_sym, value)
        }
        action_specification
      end

    end
  end
end
