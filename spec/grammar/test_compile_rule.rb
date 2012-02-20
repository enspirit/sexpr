require 'spec_helper'
module SexpGrammar
  class Grammar; public :compile_rule; end
  describe Grammar, "compile_rule" do

    def compile(name, arg)
      Grammar.new.compile_rule(name, arg)
    end

    it 'keep alternatives unchanged' do
      compile(:hello, Alternative.new([]) ).should be_a(Alternative)
    end

    it 'keep terminals unchanged' do
      compile(:hello, Terminal.new(true) ).should be_a(Terminal)
    end

    it 'keep creates a Rule englobing sequences' do
      compiled = compile(:hello, Sequence.new([]) )
      compiled.should be_a(Rule)
      compiled.name.should eq(:hello)
    end

  end
end