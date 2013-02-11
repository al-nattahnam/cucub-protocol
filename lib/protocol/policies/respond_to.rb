module Cucub
  module Protocol
    module Policies
      class RespondTo

        LVL_ANY = 0
        LVL_SAME = 1
        LVL_SPECIFIC = 2
        
        def initialize(instance_pair, class_pair, zone_pair)
          @valid_instances = Cucub::Protocol::Policies::RespondTo.parse_policy_pair_to_hash(instance_pair)
          @valid_classes = Cucub::Protocol::Policies::RespondTo.parse_policy_pair_to_hash(class_pair)
          @valid_zones = Cucub::Protocol::Policies::RespondTo.parse_policy_pair_to_hash(zone_pair)
        end

        def valid_instances_string
          valid_string_for(@valid_instances)
        end
        
        def valid_classes_string
          valid_string_for(@valid_classes)
        end
        
        def valid_zones_string
          valid_string_for(@valid_zones)
        end

        private
        def valid_string_for(hash)
          result = Cucub::Protocol::Policies::RespondTo.check_level_string(hash[:check_level])
          result << "{#{hash[:specific]}}" if hash[:check_level] == Cucub::Protocol::Policies::RespondTo::LVL_SPECIFIC
          result
        end

        def self.check_level_string(check_level)
          case check_level
            when LVL_ANY
              "any"
            when LVL_SAME
              "same"
            when LVL_SPECIFIC
              "specific"
          end
        end

        # A policy check_level/array is composed of a check_level plus a specific data (if it applies)
        def self.parse_policy_pair_to_hash(pair)
          pair = [pair] unless pair.is_a? Array
          policy_hash = { :check_level => pair[0] }
          policy_hash.merge!(:specific => pair[1]) if pair[1]
          policy_hash
        end

        def self.parse(text_config)
          Cucub::Protocol::Policies::RespondTo.new(instance_pair, class_pair, zone_pair)
        end
      end
    end
  end
end
