require 'spec_helper'
module Sexpr
  describe Rewriter do

    it 'has a SexprCoercions helper by default' do
      Rewriter.helpers.should eq([Processor::SexprCoercions])
    end

    it 'allows subclassing while conserving helpers' do
      subclass = Class.new(Rewriter)
      subclass.helpers.should eq([Processor::SexprCoercions])
      subclass.helpers.object_id.should_not eq(Rewriter.helpers.object_id)
    end

  end
end