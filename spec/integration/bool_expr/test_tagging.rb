require 'spec_helper'
describe BoolExpr, "the tagging feature" do
  subject{ BoolExpr }

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

end