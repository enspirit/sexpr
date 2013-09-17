require 'spec_helper'
require Path.backfind('examples/bool_expr/bool_expr.rb').rm_ext
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

end