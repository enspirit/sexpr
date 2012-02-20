require 'spec_helper'
module SexpGrammar
  describe "the bool_expr grammar" do

    let(:g){ SexpGrammar.load(Path.dir/"bool_expr.yml") }

    it "allows checking validy of specific nodes" do
      (g[:bool_and] === [:bool_and, true, false]).should be_true
      (g[:bool_and] === [:bool_or, true, false]).should be_false
    end

  end
end