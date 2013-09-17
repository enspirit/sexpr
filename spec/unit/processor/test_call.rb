require 'spec_helper'
module Sexpr
  describe Processor, 'call' do

    context 'without preprocessors installed' do
      let(:proc){ SimpleProcessor.new }

      it 'returns the result of apply' do
        ast = [:hello, "world"]
        proc.call(ast).should eq([:simple_hello, [:hello, "world"]])
      end

    end

    context "when preprocessors are installed" do
      let(:proc){ SubPreprocessed.new }

      it 'applies the preprocessors' do
        ast = [:hello, "world"]
        proc.call(ast).should eq([:preprocessed_hello, [:prefix_hello, "world"]])
      end

      it 'sets preprocessor results under state variables when required' do
        ast = [:hello, "world"]
        proc.call(ast)
        proc.upcased.should eq("PREFIX_HELLO")
      end

    end

    context 'when called on the class' do

      it 'returns what an instance returns' do
        expected = [:simple_hello, [:hello, "world"]]
        SimpleProcessor.call([:hello, "world"]).should eq(expected)
      end

      it 'allows passing options' do
        source   = [:hello, "world"]
        expected = [:do_hello, "world"]
        Preprocessed::Prefix.call(source, :prefix => "do_").should eq(expected)
      end

    end

  end
end