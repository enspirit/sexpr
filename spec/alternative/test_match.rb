require 'spec_helper'
module SexpGrammar
  describe Alternative, "_match" do

    let(:alt1){ Terminal.new(nil)            }
    let(:alt2){ Terminal.new(/^[a-z]+$/)     }
    let(:rule){ Alternative.new [alt1, alt2] }

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
end