module Sexpr
  class Processor
    class SexprCoercions < Helper

      def call(processor, sexpr, &bl)
        # input coercion
        sexpr = grammar(processor).sexpr(sexpr)

        # recursive call
        sexpr = next_call(processor, sexpr, bl)

        # output coercion
        if sexpr.is_a?(Array) and sexpr.first.is_a?(Symbol)
          grammar(processor).sexpr(sexpr)
        else
          sexpr
        end
      end

      private

      def grammar(processor)
        if processor.respond_to?(:sexpr_grammar)
          processor.sexpr_grammar
        else
          Sexpr
        end
      end

    end # class SexprCoercions
  end  # class Processor
end # module Sexpr