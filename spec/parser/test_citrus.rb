require 'spec_helper'
require 'citrus'
module Sexpr::Parser
  describe Citrus do

    before do
      ::Citrus.load (Path.dir/"../fixtures/bool_expr").to_s
    end

    describe 'recognizes?' do

      it 'returns true on Citrus parsers' do
        (Citrus.recognizes?(BoolExpr)).should be_true
      end

      it 'returns false when not recognized' do
        (Citrus.recognizes?(self)).should be_false
      end

    end # recognizes?

    describe 'parse' do

      let(:parser){ Citrus.new(BoolExpr) }

      it 'delegates the call to the Citrus parser' do
        parser.parse("true").should be_a(::Citrus::Match)
      end

      it 'raises a Citrus::ParserError when parsing fails' do
        lambda{
          parser.parse("bl and or")
        }.should raise_error(::Citrus::ParseError)
      end

      it 'recognizes the :root option' do
        parser.parse("true", :root => :bool_lit).should be_a(::Citrus::Match)
        parser.parse("x", :root => :var_ref).should be_a(::Citrus::Match)
        lambda{
          parser.parse("x", :root => :bool_lit)
        }.should raise_error(::Citrus::ParseError)
      end

      it 'recognizes the :consume option' do
        lambda{
          parser.parse("true or")
        }.should raise_error(::Citrus::ParseError)
        parser.parse("true or", :consume => false).should eq("true")
      end

    end # parse

    it 'should be registered' do
      Sexpr::Parser.find_parser_class(BoolExpr).should eq(Citrus)
    end

    it 'should be served for a Citrus grammar' do
      Sexpr::Parser.factor(BoolExpr).should be_a(Citrus)
    end

  end
end