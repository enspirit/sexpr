require 'spec_helper'
module Sexpr
  describe Terminal, "eat" do

    let(:rule){ Terminal.new(/^[a-z]+$/) }

    context "with a regexp" do

      it 'returns subarray when match' do
        rule.eat(["hello", "world"]).should eq(["world"])
      end

      it 'returns nil when no match' do
        rule.eat([]).should be_nil
        rule.eat(["12"]).should be_nil
      end
    end

  end
end