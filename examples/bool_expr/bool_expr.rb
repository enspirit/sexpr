require 'sexpr'

BoolExpr = Sexpr.load File.expand_path('../bool_expr.sexp.yml', __FILE__)

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

end if defined?(RSpec)