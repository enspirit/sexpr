require 'spec_helper'
module Sexpr
  describe "the bool_expr grammar" do

    let(:g){ Sexpr.load(fixtures_path/"bool_expr.sexp.yml") }

    it 'has a Citrus parser ready to parse' do
      g.parser.should be_a(Parser::Citrus)
    end

    it "allows checking validy of specific nodes" do
      (g[:bool_lit] === [:bool_lit, true]).should be_true
      (g[:var_ref]  === [:var_ref, "x"]).should be_true
      (g[:bool_and] === [:bool_and, [:bool_lit, true], [:bool_lit, false]]).should be_true
      (g[:bool_and] === [:bool_or, [:bool_lit, true], [:bool_lit, false]]).should be_false
    end

    it 'allows checking the validity against the root rule' do
      (g === [:bool_lit, true]).should be_true
      (g === [:bool_lit, false]).should be_true
      (g === [:bool_not, [:bool_lit, true]]).should be_true
      (g === [:var_ref, "x"]).should be_true
      (g === [:bool_not, [:var_ref, "x"]]).should be_true
    end

    it 'detects wrong matches' do
      (g === [:bool_not, [:something_else, "x"]]).should be_false
    end

  end
end