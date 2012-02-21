require 'spec_helper'
module Sexpr
  class Grammar; public :compile_rule_defn; end
  describe Grammar, "compile_rule_defn" do

    let(:grammar){ Grammar.new }
    subject{ grammar.compile_rule_defn(arg) }

    context 'with an Element' do
      let(:arg){ Matcher::Terminal.new(//) }
      it 'returns arg itself' do
        subject.should eq(arg)
      end
    end

    context "with true" do
      let(:arg){ true }
      it 'gives it true' do
        subject.should be_a(Matcher::Terminal)
        subject.value.should eq(true)
      end
    end

    context "with false" do
      let(:arg){ false }
      it 'gives it false' do
        subject.should be_a(Matcher::Terminal)
        subject.value.should eq(false)
      end
    end

    context "with nil" do
      let(:arg){ nil }
      it 'gives it nil' do
        subject.should be_a(Matcher::Terminal)
        subject.value.should eq(nil)
      end
    end

    context 'with an alternative array' do
      let(:arg){ [true, false, nil] }
      it 'factors an Alternative' do
        subject.should be_a(Matcher::Alternative)
      end
      it 'compiles its elements' do
        subject.terms.size.should eq(3)
        subject.terms.all?{|x| x.is_a?(Matcher::Terminal)}.should be_true
      end
    end

    context 'with a sequence array' do
      let(:arg){ [[true, false, nil]] }
      it 'factors a Sequence' do
        subject.should be_a(Matcher::Sequence)
      end
      it 'compiles its elements' do
        subject.terms.size.should eq(3)
        subject.terms.all?{|x| x.is_a?(Matcher::Terminal)}.should be_true
      end
    end

    context 'with subalternatives' do
      let(:arg){ [ ["a_rule", [false, true, nil] ]] }
      it 'compiles the last as an Alternative' do
        subject.terms.last.should be_a(Matcher::Alternative)
      end
    end

    context 'with a reference to a non-terminal' do
      let(:arg){ "a_rule" }
      it 'factors a Reference' do
        subject.should be_a(Matcher::Reference)
      end
      it 'refers to the appropriate rule name' do
        subject.rule_name.should eq(:a_rule)
      end
      it 'refers to the appropriate grammar' do
        subject.grammar.should eq(grammar)
      end
    end

    context 'with a stared non-terminal' do
      let(:arg){ "a_rule+" }
      it 'factors a Many' do
        subject.should be_a(Matcher::Many)
      end
      it 'refers to the appropriate rule' do
        subject.term.should be_a(Matcher::Reference)
        subject.term.rule_name.should eq(:a_rule)
      end
      it 'refers to the appropriate multiplicities' do
        subject.min.should eq(1)
        subject.max.should be_nil
      end
    end

  end
end