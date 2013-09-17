require 'spec_helper'
module Sexpr
  describe Rewriter, "copy_and_apply" do

    let(:rwclass){
      Class.new(Rewriter){
        def on_hello(sexpr)
          copy_and_apply(sexpr)
        end
        def on_lit(sexpr)
          [:lit, sexpr.last.upcase]
        end
      }
    }
    let(:rw){ rwclass.new }

    it 'provides a friendly way of rewriting' do
      sexpr = [:hello, [:lit, "world"]]
      rw.call(sexpr).should eq([:hello, [:lit, "WORLD"]])
    end

    it 'extends input and output sexpr with the Sexpr module' do
      sexpr = [:hello, [:lit, "world"]]
      rw.call(sexpr).should be_a(Sexpr)
      sexpr.should be_a(Sexpr)
    end

  end
end