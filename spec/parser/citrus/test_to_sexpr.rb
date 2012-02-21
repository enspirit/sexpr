require 'spec_helper'
module Sexpr::Parser
  describe Citrus, "to_sexpr" do

    it 'calls value by default' do
      parser = Citrus.new(bool_expr_parser)
      parser.to_sexpr("true").should eq(true)
    end

    it 'delegates to from_match_to_sexpr if specified' do
      parser = Citrus.new(bool_expr_parser, :from_match_to_sexpr => lambda{|x| 12})
      parser.to_sexpr("true").should eq(12)
    end

  end
end