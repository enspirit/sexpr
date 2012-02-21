require 'spec_helper'
module Sexpr::Parser
  describe Citrus, "recognize?" do

    it 'returns true on Citrus parsers' do
      Citrus.should be_recognize(BoolExpr)
    end

    it 'returns true on a Citrus Path' do
      Citrus.should be_recognize(fixtures_path/"bool_expr.citrus")
    end

    it 'returns false when not recognized' do
      (Citrus.recognizes?(self)).should be_false
    end

  end
end