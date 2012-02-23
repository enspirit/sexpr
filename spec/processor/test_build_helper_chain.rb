require 'spec_helper'
module Sexpr
  describe Processor, "build_helper_chain" do

    def chain(helpers)
      Processor.build_helper_chain(helpers)
    end

    it 'returns a NullHelper instance when the chain is empty' do
      chain([]).should be_a(Processor::NullHelper)
    end

    it 'returns an instance of the first helper when a singleton chain' do
      chain([ FooHelper ]).should be_a(FooHelper)
    end

    it 'returns chained helpers when a list' do
      chain = chain([ FooHelper, BarHelper ])
      chain.should be_a(FooHelper)
      chain.next_in_chain.should be_a(BarHelper)
    end

  end
end