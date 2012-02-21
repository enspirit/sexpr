require 'spec_helper'
module Sexpr::Parser
  describe Citrus do

    it 'should be registered' do
      Sexpr::Parser.find_parser_class(bool_expr_parser).should eq(Citrus)
    end

    it 'should be served for a Citrus grammar' do
      Sexpr::Parser.factor(bool_expr_parser).should be_a(Citrus)
    end

    it 'should accept factor options, defaulting to defaults' do
      cit = Sexpr::Parser.factor(bool_expr_parser, {:hello => "World"})
      cit.options[:hello].should eq("World")
      cit.options.should have_key(:from_match_to_sexpr)
    end

  end
end