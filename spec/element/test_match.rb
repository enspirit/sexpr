require 'spec_helper'
module SexpGrammar
  describe Element, "match?" do
    include Element

    def _match(sexp, matches)
      @match
    end

    it 'returns false when not an array' do
      match?(nil).should be_false
      match?(12).should be_false
    end

    it 'returns true if a match' do
      @match = []
      match?([:hello]).should be_true
    end

    it 'returns false if no match' do
      @match = nil
      match?([:hello]).should be_false
    end

  end
end