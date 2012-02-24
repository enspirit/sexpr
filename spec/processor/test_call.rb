require 'spec_helper'
module Sexpr
  describe Processor, 'call' do

    let(:proc){ SimpleProcessor.new }

    it 'dispatches to existing methods' do
      ast = [:hello, "world"]
      proc.call(ast).should eq([:simple_hello, [:hello, "world"]])
    end

    it 'calls on_missing when not found' do
      ast = [:simple_missing, "world"]
      proc.call(ast).should eq([:simple_pass_missing, ast])
    end

    it 'raises unexpected by default in on_missing' do
      ast = [:nonono, "world"]
      lambda{ proc.call(ast) }.should raise_error(UnexpectedSexprError, /nonono/)
    end

    it 'raises an ArgumentError unless called on a sexpr' do
      lambda{
        proc.call("world").should raise_error(ArgumentError, /world/)
      }
    end

  end
end