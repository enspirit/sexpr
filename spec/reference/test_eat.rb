require 'spec_helper'
module SexpGrammar
  describe Reference, "eat" do

    let(:grammar){ {:hello => Terminal.new(/^[a-z]+$/)} }
    let(:rule)   { Reference.new :hello, grammar        }

    it 'delegates the call' do
      rule.eat(["hello", "world"]).should eq(["world"])
    end

  end
end