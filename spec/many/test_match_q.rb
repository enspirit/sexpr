require 'spec_helper'
module Sexpr
  describe Many do

    let(:term){ Terminal.new(/^[a-z]+$/) }
    let(:rule){ Many.new term, '+'       }

    it 'returns true on match' do
      rule.should be_match(["hello"])
      rule.should be_match(["hello", "world"])
    end

    it 'returns false on partial match' do
      rule.should_not be_match(["hello", "world", "12"])
    end

    it 'returns false on no match' do
      rule.should_not be_match(["12"])
      rule.should_not be_match([])
      rule.should_not be_match(nil)
    end

  end
end