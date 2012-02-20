require 'spec_helper'
module SexpGrammar
  describe "the bool_expr grammar" do

    let(:g){ SexpGrammar.load(Path.dir/"bool_expr.yml") }

    it "allows checking validy of specific nodes" do
      pending{ (g[:bool_lit] === true).should be_true }
      (g[:bool_and] === [:bool_and, true, false]).should be_true
      (g[:bool_and] === [:bool_or, true, false]).should be_false
    end

    it 'allows checking the validity against the root rule' do
      pending{
        (g === true).should be_true
        (g === false).should be_true
      }
      (g === [:bool_not, true]).should be_true
      (g === [:var_ref, "x"]).should be_true
      (g === [:bool_not, [:var_ref, "x"]]).should be_true
    end

    it 'detects wrong matches' do
      (g === [:bool_not, [:something_else, "x"]]).should be_false
    end

  end
end