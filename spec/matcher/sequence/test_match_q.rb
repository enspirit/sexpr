require 'spec_helper'
module Sexpr::Matcher
  describe Sequence, 'match?' do

    let(:alt1){ Terminal.new(nil)          }
    let(:alt2){ Terminal.new(/^[a-z]+$/)   }
    let(:rule){ Sequence.new [alt1, alt2]  }

    it 'returns true on match' do
      rule.should be_match([nil, "hello"])
    end

    it 'returns false on partial match' do
      rule.should_not be_match([nil, "hello", "world"])
    end

    it 'returns false on no match' do
      rule.should_not be_match([:hello, 12])
      rule.should_not be_match([])
      rule.should_not be_match(nil)
      rule.should_not be_match([nil])
    end

  end
end
