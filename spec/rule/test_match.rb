require 'spec_helper'
module SexpGrammar
  describe Rule do

    let(:defn){ Terminal.new(/^[a-z]+$/) }
    let(:rule){ Rule.new :hello, defn }

    describe "_match" do

      it 'returns an empty array when match' do
        rule._match([:hello, "world"], {}).should eq([])
      end

      it 'keps match info' do
        h = {}
        rule._match([:hello, "world"], h)
        h[defn].should eq(["world"])
      end

      it 'returns nil when not match' do
        rule._match([:hello, "12"], {}).should be_nil
        rule._match([:hello], {}).should be_nil
      end

    end

    describe "match?" do

      it 'returns true on match' do
        rule.should be_match([:hello, "hello"])
      end

      it 'returns false on partial match' do
        rule.should_not be_match([:hello, "hello", "world"])
      end

      it 'returns false on no match' do
        rule.should_not be_match([:hello, 12])
        rule.should_not be_match([])
        rule.should_not be_match(nil)
      end

    end

  end
end