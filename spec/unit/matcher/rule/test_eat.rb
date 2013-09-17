require 'spec_helper'
module Sexpr::Matcher
  describe Rule, "eat" do

    let(:defn){ Sequence.new [Terminal.new(/^[a-z]+$/)] }
    let(:rule){ Rule.new :hello, defn }

    it 'returns the trailing array when match' do
      rule.eat([[:hello, "world"], "!"]).should eq(["!"])
    end

    it 'returns nil when not match' do
      rule.eat([:hello, "world"]).should be_nil
      rule.eat([:hello]).should be_nil
      rule.eat([]).should be_nil
      rule.eat([[]]).should be_nil
      rule.eat([nil]).should be_nil
    end

  end
end