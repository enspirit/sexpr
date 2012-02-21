require 'spec_helper'
module Sexpr
  describe Grammar, "install_parser_option" do

    def grammar(options = {})
      Sexpr.load({}, options)
    end

    it 'is nil by default' do
      grammar.parser.should be_nil
    end

    it 'can be specified through a :parser option' do
      g = grammar(:parser => BoolExpr)
      g.parser.should be_a(Parser::Citrus)
    end

  end
end