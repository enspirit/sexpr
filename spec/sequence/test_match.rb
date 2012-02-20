require 'spec_helper'
module SexpGrammar
  describe Sequence do

    let(:alt1){ Terminal.new(nil)          }
    let(:alt2){ Terminal.new(/^[a-z]+$/)   }
    let(:rule){ Sequence.new [alt1, alt2]  }

    describe "_match" do

      it 'returns the subarray when match' do
        rule._match([nil, "world", "then"], {}).should eq(["then"])
      end

      it 'keps match info' do
        h = {}
        rule._match([nil, "world", "then"], h)
        h[alt1].should eq([nil])
        h[alt2].should eq(["world"])
      end

      it 'returns nil when no match' do
        rule._match([], {}).should be_nil
        rule._match(["12"], {}).should be_nil
        rule._match([nil], {}).should be_nil
      end

      it 'does not keep partial matches results' do
        h = {}
        rule._match([nil, "12"], {})
        h[alt1].should be_nil
      end

    end

    describe "match?" do

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
      end

    end

  end
end