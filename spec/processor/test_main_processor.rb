require 'spec_helper'
module Sexpr
  describe Processor, "main_processor" do

    let(:procclass){ Class.new(Processor) }

    it 'defaults to self' do
      proc = procclass.new
      proc.main_processor.should eq(proc)
    end

    it 'may be specified through options' do
      proc = procclass.new(:main_processor => :hello)
      proc.main_processor.should eq(:hello)
    end

  end
end