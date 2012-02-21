require 'spec_helper'
module Sexpr::Matcher
  describe Sequence, "eat" do

    let(:alt1){ Terminal.new(nil)          }
    let(:alt2){ Terminal.new(/^[a-z]+$/)   }
    let(:rule){ Sequence.new [alt1, alt2]  }

    it 'returns the subarray when match' do
      rule.eat([nil, "world", "then"]).should eq(["then"])
    end

    it 'returns nil when no match' do
      rule.eat([]).should be_nil
      rule.eat(["12"]).should be_nil
      rule.eat([nil]).should be_nil
    end

  end
end
