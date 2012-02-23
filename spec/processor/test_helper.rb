require 'spec_helper'
module Sexpr
  describe Processor, "helper" do

    it 'installs the helping class in the registered helpers' do
      Processor.helpers.should eq([])
      FooProcessor.helpers.should eq([FooHelper])
      BarProcessor.helpers.should eq([FooHelper, BarHelper])
    end

    it 'extends the processor classes with Methods modules' do
      FooProcessor.included_modules.should be_include(FooHelper::Methods)
      FooProcessor.included_modules.should_not be_include(BarHelper::Methods)
      BarProcessor.included_modules.should be_include(FooHelper::Methods)
      BarProcessor.included_modules.should be_include(BarHelper::Methods)
    end

  end
end