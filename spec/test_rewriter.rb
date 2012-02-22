require 'spec_helper'
module Sexpr
  describe Rewriter do

    it 'has a SexprCoercions helper by default' do
      Rewriter.helper_chain.size.should eq(1)
      Rewriter.helper_chain.last.should be_a(Processor::SexprCoercions)
    end

    it 'allows subclassing while conserving helpers' do
      subclass = Class.new(Rewriter)
      subclass.helper_chain.size.should eq(1)
      subclass.helper_chain.last.should be_a(Processor::SexprCoercions)
      subclass.helper_chain.last.should_not eq(Rewriter.helper_chain)
    end

  end
end