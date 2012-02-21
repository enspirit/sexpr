require 'spec_helper'
module Sexpr
  describe Sexpr, "load" do

      let(:grammar){ Sexpr.load(arg) }

      context "on a YAML path" do
        let(:arg){ Path.dir/"fixtures/bool_expr.sexp.yml" }

        it 'returns a Grammar' do
          grammar.should be_a(Grammar)
        end

      end # grammar.yml

      context 'with a Hash' do
        let(:arg){ {:hello => /[a-z]+/} }

        it 'returns a Grammar' do
          grammar.should be_a(Grammar)
        end

      end

      context 'with a String' do
        let(:arg){ "hello: true" }

        it 'returns a Grammar' do
          grammar.should be_a(Grammar)
        end

      end

  end
end