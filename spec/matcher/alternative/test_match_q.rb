require 'spec_helper'
module Sexpr::Matcher
  describe Alternative, "match?" do

    let(:alt1){ Terminal.new(nil)            }
    let(:alt2){ Terminal.new(/^[a-z]+$/)     }
    let(:rule){ Alternative.new [alt1, alt2] }

    it 'returns true if one matches' do
      rule.should be_match("hello")
      rule.should be_match(nil)
    end

    it 'returns false on no match' do
      rule.should_not be_match("12")
      rule.should_not be_match([])
    end

  end
end
