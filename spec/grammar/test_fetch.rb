require 'spec_helper'
module SexpGrammar
  describe Grammar, "fetch" do

    let(:grammar){
      SexpGrammar.load(:terminal => /[a-z]+/)
    }

    it 'returns the rule when it exists' do
      grammar[:terminal].should be_a(Terminal)
    end

    it 'returns nil otherwise' do
      grammar[:nosuchone].should be_nil
    end

  end
end # module SexpGrammar