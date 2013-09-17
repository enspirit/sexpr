require 'spec_helper'
module Sexpr
  describe Processor, 'apply' do

    let(:proc){ SimpleProcessor.new }

    it 'dispatches to existing methods' do
      ast = [:hello, "world"]
      proc.apply(ast).should eq([:simple_hello, [:hello, "world"]])
    end

    it 'calls on_missing when not found' do
      ast = [:simple_missing, [:hello, "world"]]
      proc.apply(ast).should eq([:simple_pass_missing, ast])
    end

    it 'can be called from the inside' do
      ast = [:apply, [:hello, "world"]]
      proc.apply(ast).should eq([:simple_hello, [:hello, "world"]])
    end

    it 'raises unexpected by default in on_missing' do
      ast = [:nonono, "world"]
      lambda{ proc.apply(ast) }.should raise_error(UnexpectedSexprError, /nonono/)
    end

    it 'raises an ArgumentError unless called on a sexpr' do
      lambda{
        proc.apply("world").should raise_error(ArgumentError, /world/)
      }
    end

  end
end