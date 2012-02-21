require 'sexpr'
module BoolExpr
  Grammar = Sexpr.load File.expand_path('../bool_expr.sexp.yml', __FILE__)

end

describe BoolExpr::Grammar do

  def parse(*args)
    BoolExpr::Grammar.parse(*args)
  end

  def to_sexpr(*args)
    BoolExpr::Grammar.to_sexpr(*args)
  end

  it 'parses boolean expressions without error' do
    parse("x and y").should be_a(Citrus::Match)
  end

  it 'provides a helper to get s-expressions' do
    to_sexpr("x and y").should be_a(Array)
  end

end if defined?(RSpec)