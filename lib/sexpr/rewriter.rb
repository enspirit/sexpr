module Sexpr
  class Rewriter < Processor
    helper SexprCoercions

    def self.grammar(sexpr_grammar)
      @sexpr_grammar = sexpr_grammar
    end

    def sexpr_grammar
      (self.class.instance_variable_get(:"@sexpr_grammar") || super) rescue Sexpr
    end

    def copy_and_apply(sexpr)
      sexpr.sexpr_copy do |copy, child|
        copy << (Sexpr===child ? call(child) : child)
      end
    end

  end # class Rewriter
end # module Sexpr