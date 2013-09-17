require 'sexpr'
require 'citrus'

# Let load the grammar from the .yml definition file.
BoolExpr = Sexpr.load File.expand_path('../bool_expr.sexp.yml', __FILE__)

# A Sexpr grammar is simply a module. Ruby allows us to re-open it later.
module BoolExpr

  # These are the modules automatically installed on the s-expressions
  # that the grammar produces
  module And;     end
  module Or;      end
  module Not;     end
  module Lit;     end
  module VarRef;  end

  # The two following methods allows converting rule names (e.g. bool_and)
  # to module names (And). A default implementation is provided by Sexpr
  # that enforces convention over configuration (BoolAnd <-> bool_and). We
  # override the methods here for the sake of the example/documentation.

  def rule2modname(rule)
    (rule.to_s =~ /^bool_(.*)$/) ? $1.capitalize.to_sym : super
  end

  def mod2rulename(mod)
    rule = super
    (rule.to_s =~ /^bool_(.*)$/) ? const_get($1.to_sym) : rule
  end

  # This class pushes `[:not, ...]` as far as possible in boolean expressions.
  # It provides an example of s-expression rewriter
  class NotPushProcessor < Sexpr::Rewriter

    # Let the default implementation know that we are working on the BoolExpr
    # grammar. This way, all rewriting results will automatically be tagged
    # with the correct modules above (And, Not, ...)
    grammar BoolExpr

    # The main rewriting rule, that pushes a NOT according to the different
    # cases
    def on_bool_not(sexpr)
      case expr = sexpr.last
      when And then apply [:bool_or,  [:bool_not, expr[1]], [:bool_not, expr[2]] ]
      when Or  then apply [:bool_and, [:bool_not, expr[1]], [:bool_not, expr[2]] ]
      when Not then apply expr.last
      when Lit then [:bool_lit, !expr.last]
      else
        sexpr
      end
    end

    # By default, we simply copy the node and apply rewriting rules on children
    alias :on_missing :copy_and_apply

  end # class NotPushProcessor

end # module BoolExpr