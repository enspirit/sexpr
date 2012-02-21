require 'spec_helper'
module Sexpr::Parser
  describe Citrus do

    it 'should be registered' do
      Sexpr::Parser.find_parser_class(BoolExpr).should eq(Citrus)
    end

    it 'should be served for a Citrus grammar' do
      Sexpr::Parser.factor(BoolExpr).should be_a(Citrus)
    end

  end
end