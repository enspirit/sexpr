require 'spec_helper'
module Sexpr
  describe Sexpr, "load" do

      subject{ Sexpr.load(arg) }

      after do
        subject.should be_a(Module)
        subject[:bool_expr].should be_a(Matcher::Alternative)
      end

      context "on a YAML path" do
        let(:arg){ fixtures_path/"bool_expr.sexp.yml" }

        it 'sets the path on the grammar' do
          subject.path.should eq(arg)
        end

        it 'finds the parser with the relative path' do
          subject.parser.should be_a(Parser::Citrus)
        end

      end # grammar.yml

      context "on a YAML path as a String" do
        let(:arg){ (fixtures_path/"bool_expr.sexp.yml").to_s }

        it 'sets the path on the grammar' do
          subject.path.should eq(arg)
        end

        it 'finds the parser with the relative path' do
          subject.parser.should be_a(Parser::Citrus)
        end

      end # grammar.yml

      context 'with an explicit Hash' do
        let(:arg){ {:rules => {:bool_expr => [true, false]}} }

        it 'does not set a path' do
          subject.path.should be_nil
        end

      end

      context 'with a String' do
        let(:arg){
          <<-YAML
            rules:
              bool_expr: [true, false]
          YAML
        }

        it 'does not set a path' do
          subject.path.should be_nil
        end

      end

  end
end