require 'spec_helper'
module Sexpr::Parser
  describe Citrus, "sexpr" do

    it 'calls value by default' do
      parser = Citrus.new(bool_expr_parser)
      parser.sexpr("true").should eq([:bool_lit, true])
    end

    it 'delegates to from_match_to_sexpr if specified' do
      parser = Citrus.new(bool_expr_parser, :from_match_to_sexpr => lambda{|x| 12})
      parser.sexpr("true").should eq(12)
    end

  end
end