require 'spec_helper'
module Sexpr::Grammar
  describe Tagging, "rule2modname" do
    include Tagging

    it 'work on simple rule name' do
      rule2modname(:test).should eq(:Test)
    end

    it 'works when underscores are present' do
      rule2modname(:a_rule_name).should eq(:ARuleName)
    end

    it 'works with a string' do
      rule2modname("a_rule_name").should eq(:ARuleName)
    end

  end
end