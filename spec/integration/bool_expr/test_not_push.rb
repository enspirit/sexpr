require 'spec_helper'
describe BoolExpr::NotPushProcessor do
  subject{ BoolExpr }

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

end