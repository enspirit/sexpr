require 'spec_helper'
module Sexpr::Matcher
  describe Alternative, "eat" do

    let(:alt1){ Terminal.new(nil)            }
    let(:alt2){ Terminal.new(/^[a-z]+$/)     }
    let(:rule){ Alternative.new [alt1, alt2] }

    it 'returns the subarray when match' do
      rule.eat(["hello", "world"]).should eq(["world"])
      rule.eat([nil, "world"]).should eq(["world"])
    end

    it 'returns nil when no match' do
      rule.eat([]).should be_nil
      rule.eat(["12"]).should be_nil
    end

  end
end
