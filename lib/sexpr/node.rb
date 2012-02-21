module Sexpr
  module Node

    def sexpr_type
      first
    end
    alias :sexp_type :sexpr_type

    def sexpr_body
      self[1..-1]
    end
    alias :sexp_body :sexpr_body

  end # module Node
  include Node
end # module Sexpr