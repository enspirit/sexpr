require 'spec_helper'
module Sexpr::Parser
  describe Citrus do

    it 'should be registered' do
      Sexpr::Parser.find_parser_class(bool_expr_parser).should eq(Citrus)
    end

    it 'should be served for a Citrus grammar' do
      Sexpr::Parser.factor(bool_expr_parser).should be_a(Citrus)
    end

  end
end