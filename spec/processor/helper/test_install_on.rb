require 'spec_helper'
module Sexpr
  class Processor
    describe Helper, "install_on" do

      class FooHelper < Helper
        module Methods end
      end
      class FooProcessor < Processor
        FooHelper.install_on(self)
      end

      it 'installs the methods module on the processor' do
        modules = FooProcessor.included_modules
        modules.include?(FooHelper::Methods).should be_true
      end

      it 'adds an instance of the helper to the helpers list' do
        helper = FooProcessor.helpers.last
        helper.should be_a(FooHelper)
      end

      it 'does not polute the Processor class' do
        Processor.helpers.size.should eq(0)
      end

    end
  end
end