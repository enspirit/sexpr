require 'spec_helper'
module SexpGrammar
  describe Reference, "_match" do

    let(:grammar){ {:hello => self} }
    let(:rule)   { Reference.new :hello, grammar }

    def _match(sexp, matches)
      @called = [sexp, matches]
    end

    it 'delegates the call' do
      rule._match(["world"], {})
      @called.should eq([["world"], {}])
    end

  end
end