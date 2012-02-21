require 'spec_helper'
module Sexpr
  describe Many, "eat" do

    let(:term){ Terminal.new(/^[a-z]+$/)   }
    let(:rule){ Many.new term, min, max    }

    context "when set for *" do
      let(:min){ 0   }
      let(:max){ nil }

      it 'returns the subarray when zero match' do
        rule.eat([nil, "world", "then"]).should eq([nil, "world", "then"])
      end

      it 'returns the subarray when one match' do
        rule.eat(["world", nil, "then"]).should eq([nil, "then"])
      end

      it 'returns the subarray when multiple matches' do
        rule.eat(["world", "then"]).should eq([])
      end

    end # *

    context "when set for +" do
      let(:min){ 1   }
      let(:max){ nil }

      it 'returns nil zero match' do
        rule.eat([nil, "world", "then"]).should be_nil
      end

      it 'returns the subarray when one match' do
        rule.eat(["world", nil, "then"]).should eq([nil, "then"])
      end

      it 'returns the subarray when multiple matches' do
        rule.eat(["world", "then"]).should eq([])
      end

    end # +

    context "when set for ?" do
      let(:min){ 0 }
      let(:max){ 1 }

      it 'returns the subarray when zero match' do
        rule.eat([nil, "world", "then"]).should eq([nil, "world", "then"])
      end

      it 'returns the subarray when one match' do
        rule.eat(["world", "then"]).should eq(["then"])
      end

    end # ?

  end
end