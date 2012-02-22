require 'sexpr'
require 'citrus'

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

  # This class pushes `[:not, ...]` as far as possible in boolean expressions.
  # It provides an example of s-expression rewriter
  class NotPushProcessor < Sexpr::Rewriter

    # Let the default implementation know that we are working on the BoolExpr
    # grammar. This way, all rewriting results will automatically be tagged
    # with the correct modules above (And, Not, ...)
    grammar BoolExpr

    # The main rewriting rule, that pushes a NOT according to the different
    # cases
    def on_bool_not(sexpr)
      case expr = sexpr.last
      when And then call [:bool_or,  [:bool_not, expr[1]], [:bool_not, expr[2]] ]
      when Or  then call [:bool_and, [:bool_not, expr[1]], [:bool_not, expr[2]] ]
      when Not then call expr.last
      when Lit then [:bool_lit, !expr.last]
      else
        sexpr
      end
    end

    # By default, we simply copy the node and apply rewriting rules on children
    alias :on_missing :copy_and_apply

  end # class NotPushProcessor

end # module BoolExpr

describe BoolExpr do
  subject{ BoolExpr }

  describe "the parsing feature" do

    it 'parses boolean expressions without error' do
      subject.parse("x and y").should be_a(Citrus::Match)
      subject.parse("not(y)").should be_a(Citrus::Match)
      subject.parse("not(true)").should be_a(Citrus::Match)
    end

    it 'provides a shortcut to get s-expressions directly' do
      subject.sexpr("x and y").should eq([:bool_and, [:var_ref, "x"], [:var_ref, "y"]])
    end

  end # parsing

  describe "the tagging feature" do

    it 'tags parsing results with the Sexpr module' do
      sexpr = subject.sexpr("x and y")
      sexpr.should be_a(Sexpr)
      sexpr.sexpr_type.should eq(:bool_and)
      sexpr.sexpr_body.should eq([[:var_ref, "x"], [:var_ref, "y"]])
    end

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

  describe BoolExpr::NotPushProcessor do

    def _(expr)
      BoolExpr.sexpr(expr)
    end

    def rw(expr)
      BoolExpr::NotPushProcessor.new.call(expr)
    end

    it 'does nothing on variable references' do
      rw("not x").should eq([:bool_not, [:var_ref, "x"]])
    end

    it 'rewrites literals through negating them' do
      rw("not true").should  eq(_ "false")
      rw("not false").should eq(_ "true")
    end

    it 'rewrites not through removing them' do
      rw("not not true").should eq(_ "true")
    end

    it 'rewrites or through and of negated terms' do
      rw("not(x or y)").should eq(_ "not(x) and not(y)")
    end

    it 'rewrites and through or of negated terms' do
      rw("not(x and y)").should eq(_ "not(x) or not(y)")
    end

    it 'rewrites recursively' do
      rw("not(x and not(y))").should eq(_ "not(x) or y")
    end

  end # rewriting

end if defined?(RSpec)