require 'spec_helper'
module Sexpr::Parser
  describe Citrus, "new" do

    it 'factors a Parser instance when a Citrus::Grammar' do
      p = Citrus.new(BoolExpr)
      p.should be_a(Citrus)
      p.parser.should eq(BoolExpr)
    end

    it 'factors a Parser instance when a Path to a .citrus file' do
      p = Citrus.new(fixtures_path/"bool_expr.citrus")
      p.should be_a(Citrus)
      p.parser.should eq(BoolExpr)
    end

    it 'factors a Parser instance when a Path to a .citrus file' do
      p = Citrus.new (fixtures_path/"bool_expr.citrus").to_s
      p.should be_a(Citrus)
      p.parser.should eq(BoolExpr)
    end

    it 'passes the options' do
      Citrus.new(BoolExpr, {:hello => "World"}).options[:hello].should eq("World")
    end

  end
end