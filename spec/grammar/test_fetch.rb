require 'spec_helper'
module Sexpr
  describe Grammar, "fetch" do

    let(:grammar){
      Sexpr.load(:terminal => /[a-z]+/)
    }

    it 'returns the rule when it exists' do
      grammar[:terminal].should be_a(Matcher::Terminal)
    end

    it 'returns nil otherwise' do
      grammar[:nosuchone].should be_nil
    end

  end
end # module Sexpr