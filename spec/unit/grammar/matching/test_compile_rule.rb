require 'spec_helper'
module Sexpr
  module Grammar
    describe Matching, "compile_rule" do
      include Matching

      subject{ compile_rule(:hello, defn) }

      shared_examples_for 'a terminal rule' do
        it{ should be_a(Matcher::Rule) }

        it 'should have the expected defn' do
          subject.defn.should be(defn)
        end

        it 'should have the correct name' do
          subject.name.should eq(:hello)
        end
      end

      shared_examples_for 'a non-terminal rule' do
        it{ should be_a(Matcher::Rule) }

        it 'should have the expected non-terminal' do
          subject.defn.should be_a(Matcher::NonTerminal)
          subject.defn.name.should eq(:hello)
          subject.defn.defn.should be(defn)
        end

        it 'should have the correct name' do
          subject.name.should eq(:hello)
        end
      end

      context 'on Alternative' do
        let(:defn){ Matcher::Alternative.new([]) }

        it_should_behave_like "a terminal rule"
      end

      context 'on Terminal' do
        let(:defn){ Matcher::Terminal.new(true) }

        it_should_behave_like "a terminal rule"
      end

      context 'on Sequence' do
        let(:defn){ Matcher::Sequence.new([]) }

        it_should_behave_like "a non-terminal rule"
      end

    end
  end
end