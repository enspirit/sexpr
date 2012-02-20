require 'spec_helper'
module SexpGrammar
  describe Terminal, "_match" do

    let(:rule){ Terminal.new(arg) }

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
end