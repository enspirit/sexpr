module Sexpr
  class Rewriter < Processor
    helper SexprCoercions

    def copy_and_apply(sexpr)
      sexpr.sexpr_copy do |copy, child|
        copy << (Sexpr===child ? apply(child) : child)
      end
    end

  end # class Rewriter
end # module Sexpr