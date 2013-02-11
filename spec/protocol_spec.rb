require 'spec_helper'

describe Cucub::Protocol::Loader do
  before do
    @filepath = File.dirname(File.expand_path(__FILE__))
  end

  describe "#parse" do
    subject { Cucub::Protocol::Loader.new }
    context "when parsing a valid config" do
      before { subject.set_path(@filepath + "/mock/protocol.ini") }
      it { subject.parse.should be_a Cucub::Protocol::SpecificationSet }
    end
    
    context "when parsing an unexisting file" do
      before { subject.set_path(@filepath + "/mock/unexisting.ini") }
      it { subject.parse.should == false }
    end

=begin
    it "should return a valid SpecificationSet" do
      @loader = Cucub::Protocol::Loader.instance
      @loader.set_path(@filepath + "/mock/protocol.ini")
      specification_set = @loader.parse
      specification_set.object_specifications.each {|obj_spec|
        puts "object: #{obj_spec.class_name}"
        puts "serialize: #{obj_spec.serialize}"
        obj_spec.action_specifications.each {|act|
          puts "\taction: #{act.action_name}"
          puts "\tserialize: #{act.serialize}"
        }
        puts "\n"
        #puts obj_spec.inspect
      }
    end
=end
    
=begin
    it "should return a valid SpecificationSet" do
      @loader = Cucub::Protocol::Loader.instance
      @loader.set_path(@filepath + "/mock/protocol.ini")
      specification_set = @loader.parse
      specification_set.object_specifications.each {|obj_spec|
        puts "object: #{obj_spec.class_name}"
        puts "uses box: #{obj_spec.uses_box}"
        puts "uses mailbox: #{obj_spec.uses_mailbox}"
        puts "uses board: #{obj_spec.uses_board}"
        obj_spec.action_specifications.each {|act|
          puts "\taction: #{act.action_name}"
          puts "\tuses box: #{act.uses_box}"
          puts "\tuses mailbox: #{act.uses_mailbox}"
          puts "\tuses board: #{act.uses_board}"
        }
        puts "\n"
        #puts obj_spec.inspect
      }
    end
=end
  end
end
