module Sexpr
  class Processor
    class NullHelper

      def call(processor, sexpr, &bl)
        bl.call(processor, sexpr)
      end

    end # class NullHelper
  end # class Processor
end # module Sexpr