module Sexpr
  class Processor
    class SexprCoercions < Helper

      module Methods

        def parse(*args)
          grammar.parse(*args)
        end

        def sexpr(*args)
          grammar.sexpr(*args)
        end

      end

      def call(processor, sexpr, &bl)
        g = processor.class.grammar

        # input coercion
        sexpr = g.sexpr(sexpr)

        # recursive call
        sexpr = next_call(processor, sexpr, bl)

        # output coercion
        if sexpr.is_a?(Array) and sexpr.first.is_a?(Symbol)
          g.sexpr(sexpr)
        else
          sexpr
        end
      end

    end # class SexprCoercions
  end  # class Processor
end # module Sexpr