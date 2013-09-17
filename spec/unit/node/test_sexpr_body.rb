require 'spec_helper'
module Sexpr
  describe Node, "sexpr_body" do

    it 'returns the head' do
      sexpr([:lit, true]).sexpr_body.should eq([true])
    end

    it 'returns an empty array if no body' do
      sexpr([:lit]).sexpr_body.should eq([])
    end

    it 'is aliased as sexp_body' do
      sexpr([:lit, true]).sexp_body.should eq([true])
    end

  end
end