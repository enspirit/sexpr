module Sexpr
  class Processor
    class Helper

      attr_accessor :next_in_chain

      def call(processor, sexpr, &bl)
        meth = :"on_#{sexpr.first}"
        meth = :"on_missing" unless respond_to?(meth)
        send(meth, processor, sexpr) do |r,n|
          next_call(r, n, bl)
        end
      end

      def on_missing(processor, sexpr)
        yield(processor, sexpr)
      end

    private

      def next_call(processor, sexpr, toplevel)
        if nic = next_in_chain
          nic.call(processor, sexpr, &toplevel)
        else
          toplevel.call(processor, sexpr)
        end
      end

    end # class Helper
  end # module Processor
end # module Sexpr