require 'spec_helper'
module Sexpr
  describe Rewriter do

    it 'has a SexprCoercions helper by default' do
      Rewriter.helpers.size.should eq(1)
      Rewriter.helpers.first.should be_a(Processor::SexprCoercions)
    end

    it 'allows subclassing while conserving helpers' do
      subclass = Class.new(Rewriter)
      subclass.helpers.size.should eq(1)
      subclass.helpers.first.should be_a(Processor::SexprCoercions)
    end

  end
end