require 'spec_helper'
module Sexpr
  class Grammar
    describe Matching, "compile_rule" do
      include Matching

      it 'keep alternatives unchanged' do
        compile_rule(:hello, Matcher::Alternative.new([]) ).should be_a(Matcher::Alternative)
      end

      it 'keep terminals unchanged' do
        compile_rule(:hello, Matcher::Terminal.new(true) ).should be_a(Matcher::Terminal)
      end

      it 'keep creates a Rule englobing sequences' do
        compiled = compile_rule(:hello, Matcher::Sequence.new([]) )
        compiled.should be_a(Matcher::Rule)
        compiled.name.should eq(:hello)
      end

    end
  end
end