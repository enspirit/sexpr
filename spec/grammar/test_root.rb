require 'spec_helper'
module SexpGrammar
  describe Grammar, "root" do

    let(:rules){ {:t => /[a-z]+/, :nt => true} }

    def grammar(options = {})
      SexpGrammar.load(rules, options)
    end

    it 'is the first key by default' do
      grammar.root.value.should eq(/[a-z]+/)
    end

    it 'is the specified rule when specified' do
      grammar(:root => :nt).root.value.should eq(true)
    end

  end
end