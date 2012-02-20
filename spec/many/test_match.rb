require 'spec_helper'
module SexpGrammar
  describe Many do

    let(:term){ Terminal.new(/^[a-z]+$/)   }
    let(:rule){ Many.new term, min, max    }

    describe "_match" do

      context "when set for *" do
        let(:min){ 0   }
        let(:max){ nil }

        it 'returns the subarray when zero match' do
          rule._match([nil, "world", "then"], {}).should eq([nil, "world", "then"])
        end

        it 'returns the subarray when one match' do
          rule._match(["world", nil, "then"], {}).should eq([nil, "then"])
        end

        it 'returns the subarray when multiple matches' do
          rule._match(["world", "then"], {}).should eq([])
        end

        it 'keps match info' do
          h = {}
          rule._match(["world", "then"], h)
          h[term].should eq(["world", "then"])
        end

      end # *

      context "when set for +" do
        let(:min){ 1   }
        let(:max){ nil }

        it 'returns nil zero match' do
          rule._match([nil, "world", "then"], {}).should be_nil
        end

        it 'returns the subarray when one match' do
          rule._match(["world", nil, "then"], {}).should eq([nil, "then"])
        end

        it 'returns the subarray when multiple matches' do
          rule._match(["world", "then"], {}).should eq([])
        end

        it 'keps match info' do
          h = {}
          rule._match(["world", "then"], h)
          h[term].should eq(["world", "then"])
        end

      end # +

      context "when set for ?" do
        let(:min){ 0 }
        let(:max){ 1 }

        it 'returns the subarray when zero match' do
          rule._match([nil, "world", "then"], {}).should eq([nil, "world", "then"])
        end

        it 'returns the subarray when one match' do
          rule._match(["world", "then"], {}).should eq(["then"])
        end

        it 'keps match info' do
          h = {}
          rule._match(["world", "then"], h)
          h[term].should eq(["world"])
        end

      end # ?

    end # _match

    describe "match?" do
      let(:min){ 1   }
      let(:max){ nil }

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
end