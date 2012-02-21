require 'spec_helper'
module Sexpr
  describe Sexpr, "load" do

      let(:grammar){ Sexpr.load(arg) }

      context "on a YAML path" do
        let(:arg){ Path.dir/"fixtures/bool_expr.sexp.yml" }

        it 'returns a Grammar' do
          grammar.should be_a(Grammar)
        end

        it 'understands the rules' do
          grammar[:bool_expr].should be_a(Matcher::Alternative)
        end

        it 'sets the path on the grammar' do
          grammar.path.should eq(arg)
        end

      end # grammar.yml

      context 'with a Hash' do
        let(:arg){ {:rules => {:hello => /[a-z]+/}} }

        it 'returns a Grammar' do
          grammar.should be_a(Grammar)
        end

        it 'understands the rules' do
          grammar[:hello].should be_a(Matcher::Terminal)
        end

      end

      context 'with a String' do
        let(:arg){
          <<-YAML
            rules:
              hello: true
          YAML
        }

        it 'returns a Grammar' do
          grammar.should be_a(Grammar)
        end

        it 'understands the rules' do
          grammar[:hello].should be_a(Matcher::Terminal)
        end

      end

  end
end