require 'sexpr'

# Let load the grammar from the .yml definition file.
BoolExpr = Sexpr.load File.expand_path('../bool_expr.sexp.yml', __FILE__)

# A Sexpr grammar is simply a module. Ruby allows us to re-open it later.
module BoolExpr

  # These are the modules automatically installed on the s-expressions
  # that the grammar produces
  module And;     end
  module Or;      end
  module Not;     end
  module Lit;     end
  module VarRef;  end

  # The two following methods allows converting rule names (e.g. bool_and)
  # to module names (And). A default implementation is provided by Sexpr
  # that enforces convention over configuration (BoolAnd <-> bool_and). We
  # override the methods here for the sake of the example/documentation.

  def rule2modname(rule)
    (rule.to_s =~ /^bool_(.*)$/) ? $1.capitalize.to_sym : super
  end

  def mod2rulename(mod)
    rule = super
    (rule.to_s =~ /^bool_(.*)$/) ? const_get($1.to_sym) : rule
  end

end

describe BoolExpr do
  subject{ BoolExpr }

  describe "the parsing feature" do

    it 'parses boolean expressions without error' do
      subject.parse("x and y").should be_a(Citrus::Match)
    end

    it 'provides a shortcut to get s-expressions directly' do
      subject.sexpr("x and y").should eq([:bool_and, [:var_ref, "x"], [:var_ref, "y"]])
    end

  end # parsing

  describe "the tagging feature" do

    it 'tags parsing results with user modules' do
      subject.sexpr("x and y").should be_a(BoolExpr::And)
    end

    it 'allows tagging manually' do
      subject.sexpr([:bool_lit, true]).should be_a(BoolExpr::Lit)
    end

    it 'applies tagging recursively' do
      sexpr = subject.sexpr([:bool_not, [:bool_lit, true]])
      sexpr.last.should be_a(BoolExpr::Lit)
    end

  end # taggging

  describe 'the validation feature' do

    it 'validates s-expressions' do
      subject.match?([:bool_lit, true]).should be_true
      subject.match?([:bool_lit, "x"]).should be_false
    end

    it 'validates s-expressions against specific rules' do
      subject[:bool_lit].match?([:bool_lit, true]).should be_true
      subject[:bool_and].match?([:bool_lit, true]).should be_false
    end

  end # validating

end if defined?(RSpec)