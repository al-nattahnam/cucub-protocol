require 'spec_helper'

describe Cucub::Protocol::Policies::RespondTo do
  #before do
  #  @filepath = File.dirname(File.expand_path(__FILE__))
  #end
  describe "#valid_instances_string" do
    context "when parsing a valid config" do
      subject { Cucub::Protocol::Policies::RespondTo.new(Cucub::Protocol::Policies::RespondTo::LVL_ANY, Cucub::Protocol::Policies::RespondTo::LVL_ANY, Cucub::Protocol::Policies::RespondTo::LVL_ANY) }
      it { subject.valid_instances_string.should == "any" }
      it { subject.valid_classes_string.should == "any" }
      it { subject.valid_zones_string.should == "any" }
    end
    
    #context "when parsing an unexisting file" do
    #  before { subject.set_path(@filepath + "/mock/unexisting.ini") }
    #  it { subject.parse.should == false }
    #end

  end

  describe ".parse_policy_pair_to_hash" do
    context "when parsing a valid config" do
      subject { Cucub::Protocol::Policies::RespondTo.parse_policy_pair_to_hash(Cucub::Protocol::Policies::RespondTo::LVL_ANY) }
      it { subject[:check_level] == Cucub::Protocol::Policies::RespondTo::LVL_ANY }
    end
    
    context "when parsing a valid config" do
      subject { Cucub::Protocol::Policies::RespondTo.parse_policy_pair_to_hash([Cucub::Protocol::Policies::RespondTo::LVL_SPECIFIC, "myclass"]) }
      it { subject[:check_level] == Cucub::Protocol::Policies::RespondTo::LVL_SPECIFIC }
      it { subject[:specific] == "myclass" }
    end
    
    #context "when parsing an unexisting file" do
    #  before { subject.set_path(@filepath + "/mock/unexisting.ini") }
    #  it { subject.parse.should == false }
    #end

  end
  describe ".parse" do
    #subject { Cucub::Protocol::Loader.new }
    #context "when parsing a valid config" do
    #  subject { Cucub::Protocol::Policies::RespondTo.parse("test") }
    #  it { subject.valid_instances_string.should == "test" }
    #end
    
    #context "when parsing an unexisting file" do
    #  before { subject.set_path(@filepath + "/mock/unexisting.ini") }
    #  it { subject.parse.should == false }
    #end

  end
  
end
