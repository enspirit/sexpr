require 'spec_helper'
module Sexpr
  describe Processor, 'call' do

    let(:procclass){
      Class.new(Processor) do

        def on_hello(sexpr)
          [:seen_hello, sexpr]
        end

        def on_missing(sexpr)
          if sexpr.first == :nosuchone
            [:seen_missing, sexpr]
          else
            super
          end
        end

      end
    }
    let(:proc){ procclass.new }

    it 'dispatches to existing methods' do
      ast = [:hello, "world"]
      proc.call(ast).should eq([:seen_hello, [:hello, "world"]])
    end

    it 'calls on_missing when not found' do
      ast = [:nosuchone, "world"]
      proc.call(ast).should eq([:seen_missing, [:nosuchone, "world"]])
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