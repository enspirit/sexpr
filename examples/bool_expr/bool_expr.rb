require 'sexpr'

BoolExpr = Sexpr.load File.expand_path('../bool_expr.sexp.yml', __FILE__)
module BoolExpr
  module BoolAnd; end
  module BoolOr;  end
  module BoolNot; end
  module BoolLit; end
  module VarRef;  end
end


describe BoolExpr do
  subject{ BoolExpr }

  it 'parses boolean expressions without error' do
    subject.parse("x and y").should be_a(Citrus::Match)
  end

  it 'provides a helper to get s-expressions' do
    subject.to_sexpr("x and y").should be_a(Array)
  end

  it 'validates s-expressions' do
    subject.match?([:bool_lit, true]).should be_true
    subject.match?([:bool_lit, "x"]).should be_false
  end

  it 'validates s-expressions against specific rules' do
    subject[:bool_lit].match?([:bool_lit, true]).should be_true
    subject[:bool_and].match?([:bool_lit, true]).should be_false
  end

  it 'automatically include AST modules to sexpr' do
    subject.to_sexpr("x and y").should be_a(BoolExpr::BoolAnd)
  end

end if defined?(RSpec)