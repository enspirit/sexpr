require 'spec_helper'
module Sexpr
  describe Processor, ".grammar" do

    subject{ clazz.grammar }

    context 'on Processor itself' do
      let(:clazz){ Processor }

      it{ should be(Sexpr) }
    end

    context 'on a subclass defining a grammar' do
      let(:clazz){
        Class.new(Processor){
          grammar :foo
        }
      }

      it{ should eq(:foo) }
    end

    context 'on a subclass of a rewriter class defining a grammar' do
      let(:superclazz){
        Class.new(Processor){
          grammar :foo
        }
      }
      let(:clazz){
        Class.new(superclazz)
      }

      it{ should eq(:foo) }
    end

    context 'on a subclass that overrides the grammar' do
      let(:superclazz){
        Class.new(Processor){
          grammar :foo
        }
      }
      let(:clazz){
        Class.new(superclazz){
          grammar :bar
        }
      }

      it{ should eq(:bar) }

      it 'should not override on the parent' do
        superclazz.grammar.should eq(:foo)
      end
    end

  end
end