module Sexpr
  class Processor
    class Helper

      attr_accessor :next_in_chain

      def self.install_on(processor)
        methods = const_get(:Methods) rescue nil
        processor.module_eval do
          include methods
        end if methods
        processor.register_helper(new)
      end

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

      def last
        next_in_chain ? next_in_chain.last : self
      end

      def size
        next_in_chain ? 1 + next_in_chain.size : 1
      end

      def append(helper)
        if next_in_chain
          next_in_chain.append(helper)
        else
          @next_in_chain = helper
        end
      end

      def dup
        copy = super
        copy.next_in_chain = next_in_chain.dup if next_in_chain
        copy
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