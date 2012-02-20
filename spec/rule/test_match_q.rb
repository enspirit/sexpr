require 'spec_helper'
module SexpGrammar
  describe Rule, 'match?' do

    let(:defn){ Sequence.new [Terminal.new(/^[a-z]+$/)] }
    let(:rule){ Rule.new :hello, defn }

    it 'returns true on match' do
      rule.should be_match([:hello, "hello"])
    end

    it 'returns false on partial match' do
      rule.should_not be_match([:hello, "hello", "world"])
    end

    it 'returns false on no match' do
      rule.should_not be_match(["hello"])
      rule.should_not be_match([:hello, 12])
      rule.should_not be_match([])
      rule.should_not be_match(nil)
    end

  end
end