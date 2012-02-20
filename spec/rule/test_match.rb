require 'spec_helper'
module SexpGrammar
  describe Rule, "_match" do

    let(:defn){ Terminal.new(/^[a-z]+$/) }
    let(:rule){ Rule.new :hello, defn }

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
end