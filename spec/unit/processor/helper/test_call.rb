require 'spec_helper'
module Sexpr
  class Processor
    describe Helper, "call" do

      let(:helper)    { FooHelper.new    }
      let(:processor) { FooProcessor.new }
      let(:toplevel) {
        Proc.new do |rw,node|
          rw.should eq(processor)
          [:toplevel, node]
        end
      }

      it 'dispatches to the method when it exists' do
        expected = \
          [:foo_hello,
            [:toplevel,
              [:hello, "world"] ]]
        got = helper.call(processor, [:hello, "world"], &toplevel)
        got.should eq(expected)
      end

      it 'falls back to yielding when no method' do
        expected = \
          [:toplevel,
            [:nosuchone] ]
        got = helper.call(processor, [:nosuchone], &toplevel)
        got.should eq(expected)
      end

      it 'calls next_in_chain when set' do
        helper.next_in_chain = Class.new do
          def call(rw, node)
            raise unless rw.is_a?(FooProcessor)
            yield rw, [:next, node]
          end
        end.new

        expected = \
          [:foo_hello,
            [:toplevel,
              [:next,
                [:hello, "world"] ]]]
        got = helper.call(processor, [:hello, "world"], &toplevel)
        got.should eq(expected)
      end

    end
  end
end