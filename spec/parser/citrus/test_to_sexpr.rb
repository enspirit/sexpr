require 'spec_helper'
module Sexpr::Parser
  describe Citrus, "sexpr" do

    it 'calls value by default' do
      parser = Citrus.new(bool_expr_parser)
      parser.sexpr("true").should eq([:bool_lit, true])
    end

  end
end