require 'spec_helper'
module Sexpr::Grammar
  describe Tagging, "mod2rulename" do
    include Tagging

    it 'work on simple module name' do
      mod2rulename(:Test).should eq(:test)
    end

    it 'work on complex module name' do
      mod2rulename(:ThisIsATest).should eq(:this_is_a_test)
    end

    it 'works with a module' do
      mod2rulename(::Sexpr::Grammar).should eq(:grammar)
    end

  end
end