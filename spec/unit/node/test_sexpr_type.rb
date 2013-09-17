require 'spec_helper'
module Sexpr
  describe Node, "sexpr_type" do

    it 'returns the head' do
      sexpr([:lit, true]).sexpr_type.should eq(:lit)
    end

    it 'is aliased as sexp_type' do
      sexpr([:lit, true]).sexp_type.should eq(:lit)
    end

  end
end