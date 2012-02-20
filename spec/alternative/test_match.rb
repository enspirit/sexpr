require 'spec_helper'
module SexpGrammar
  describe Alternative do

    let(:alt1){ Terminal.new(nil)            }
    let(:alt2){ Terminal.new(/^[a-z]+$/)     }
    let(:rule){ Alternative.new [alt1, alt2] }

    describe '_match' do

      it 'returns the subarray when match' do
        rule._match(["hello", "world"], {}).should eq(["world"])
        rule._match([nil, "world"], {}).should eq(["world"])
      end

      it 'keps match info' do
        h = {}
        rule._match(["hello", "world"], h)
        h[alt2].should eq(["hello"])
      end

      it 'returns nil when no match' do
        rule._match([], {}).should be_nil
        rule._match(["12"], {}).should be_nil
      end

    end

    context 'match?' do

      it 'returns true on match' do
        rule.should be_match(["hello"])
        rule.should be_match([nil])
      end

      it 'returns false on partial match' do
        rule.should_not be_match(["hello", "world"])
      end

      it 'returns false on no match' do
        rule.should_not be_match(["12"])
        rule.should_not be_match([])
        rule.should_not be_match(nil)
      end

    end

  end
end