require 'spec_helper'
module SexpGrammar
  describe Terminal do

    let(:rule){ Terminal.new(arg) }

    describe "_match" do

      context "with a regexp" do
        let(:arg){ /^[a-z]+$/ }

        it 'returns subarray when match' do
          rule._match(["hello", "world"], {}).should eq(["world"])
        end

        it 'puts match info in the hash' do
          h = {}
          rule._match(["hello", "world"], h)
          h[rule].should eq(["hello"])
        end

        it 'returns nil when no match' do
          rule._match([], {}).should be_nil
          rule._match(["12"], {}).should be_nil
        end
      end

      context "with nil" do
        let(:arg){ nil }

        it 'puts match info in the hash' do
          h = {}
          rule._match([nil, "world"], h)
          h[rule].should eq([nil])
        end
      end

    end

    describe "match?" do
      let(:arg){ true }

      it 'returns true on match' do
        rule.should be_match([true])
      end

      it 'returns false on partial match' do
        rule.should_not be_match([true, "hello"])
      end

      it 'returns false on no match' do
        rule.should_not be_match([])
        rule.should_not be_match(nil)
      end

    end

  end
end