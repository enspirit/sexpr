require 'spec_helper'
module Sexpr
  describe Grammar, "install_parser" do

    def grammar(options = {})
      Sexpr.load(options)
    end

    it 'is nil by default' do
      grammar.parser.should be_nil
    end

    it 'can be specified through a :parser option' do
      g = grammar(:parser => bool_expr_parser)
      g.parser.should be_a(Parser::Citrus)
    end

    it 'can be specified as a Path' do
      g = grammar(:parser => fixtures_path/"bool_expr.citrus")
      g.parser.should be_a(Parser::Citrus)
    end

    it 'can be specified as relative Path' do
      g = grammar(:path => fixtures_path/"bool_expr.sexp.yml",
                  :parser => "bool_expr.citrus")
      g.parser.should be_a(Parser::Citrus)
    end

  end
end