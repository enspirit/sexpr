require 'spec_helper'
module Sexpr::Parser
  describe Citrus, "recognize?" do

    it 'returns true on Citrus parsers' do
      (Citrus.recognizes?(BoolExpr)).should be_true
    end

    it 'returns false when not recognized' do
      (Citrus.recognizes?(self)).should be_false
    end

  end
end