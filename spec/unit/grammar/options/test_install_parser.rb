require 'spec_helper'
module Sexpr
  describe Grammar::Options, "install_parser" do
    include Grammar::Options

    it 'is nil by default' do
      h = {}
      install_options h do
        parser.should be_nil
      end
    end

    it 'can be specified through a :parser option' do
      h = {:parser => bool_expr_parser}
      install_options h do
        parser.should be_a(Parser::Citrus)
      end
    end

    it 'can be specified as a Path' do
      h = {:parser => fixtures_path/"bool_expr.citrus"}
      install_options h do
        parser.should be_a(Parser::Citrus)
      end
    end

    it 'can be specified as relative Path' do
      h = {:path => fixtures_path/"bool_expr.sexp.yml",
           :parser => "bool_expr.citrus"}
      install_options h do
        parser.should be_a(Parser::Citrus)
      end
    end

  end
end