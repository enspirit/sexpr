require 'spec_helper'
module Sexpr::Matcher
  describe Reference, "match?" do

    let(:grammar){ {:hello => Terminal.new(/^[a-z]+$/)} }
    let(:rule)   { Reference.new :hello, grammar        }

    it 'returns true on match' do
      rule.should be_match("hello")
      (rule === "hello").should be_true
    end

    it 'returns false on no match' do
      rule.should_not be_match("12")
      rule.should_not be_match(nil)
      rule.should_not be_match([])
    end

  end
end
