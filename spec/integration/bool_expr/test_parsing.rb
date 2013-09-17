require 'spec_helper'
describe BoolExpr, "the parsing feature" do
  subject{ BoolExpr }

  it 'parses boolean expressions without error' do
    subject.parse("x and y").should be_a(Citrus::Match)
    subject.parse("not(y)").should be_a(Citrus::Match)
    subject.parse("not(true)").should be_a(Citrus::Match)
  end

  it 'provides a shortcut to get s-expressions directly' do
    subject.sexpr("x and y").should eq([:bool_and, [:var_ref, "x"], [:var_ref, "y"]])
  end

end
