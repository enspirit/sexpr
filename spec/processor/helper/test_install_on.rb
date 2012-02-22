require 'spec_helper'
module Sexpr
  class Processor
    describe Helper, "install_on" do

      class FooHelper < Helper
        module Methods end
      end
      class FooProcessor < Processor
        helper FooHelper
      end

      class BarHelper < Helper
        module Methods end
      end
      class BarProcessor < FooProcessor
        helper BarHelper
      end

      it 'installs the methods module on the processor' do
        modules = FooProcessor.included_modules
        modules.include?(FooHelper::Methods).should be_true
        modules.include?(BarHelper::Methods).should be_false

        modules = BarProcessor.included_modules
        modules.include?(FooHelper::Methods).should be_true
        modules.include?(BarHelper::Methods).should be_true
      end

      it 'adds an instance of the helper to the helpers list' do
        pending{
          FooProcessor.helper_chain.size.should eq(1)
          helper = FooProcessor.helper_chain.last
          helper.should be_a(FooHelper)

          BarProcessor.helper_chain.size.should eq(2)
          helper = BarProcessor.helper_chain
          helper.should be_a(FooHelper)
          helper = BarProcessor.helper_chain.last
          helper.should be_a(BarHelper)
        }
      end

      it 'does not polute the Processor class' do
        Processor.helper_chain.should be_nil
      end

    end
  end
end