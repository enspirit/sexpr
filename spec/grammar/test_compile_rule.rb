require 'spec_helper'
module Sexpr
  class Grammar; public :compile_rule; end
  describe Grammar, "compile_rule" do

    def compile(name, arg)
      Grammar.new.compile_rule(name, arg)
    end

    it 'keep alternatives unchanged' do
      compile(:hello, Matcher::Alternative.new([]) ).should be_a(Matcher::Alternative)
    end

    it 'keep terminals unchanged' do
      compile(:hello, Matcher::Terminal.new(true) ).should be_a(Matcher::Terminal)
    end

    it 'keep creates a Rule englobing sequences' do
      compiled = compile(:hello, Matcher::Sequence.new([]) )
      compiled.should be_a(Matcher::Rule)
      compiled.name.should eq(:hello)
    end

  end
end
