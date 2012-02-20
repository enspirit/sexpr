require 'spec_helper'
module SexpGrammar
  describe Reference, "_match" do

    let(:grammar){ {:hello => Terminal.new(/^[a-z]+$/)} }
    let(:rule)   { Reference.new :hello, grammar        }

    it 'delegates the call' do
      rule._match(["world"], {}).should eq([])
    end

  end
end