require 'sexpr'
module BoolExpr
  Grammar = Sexpr.load File.expand_path('../bool_expr.sexp.yml', __FILE__)

end