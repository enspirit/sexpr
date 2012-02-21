require 'epath'
root = Path.backfind('.[lib]')

require 'citrus'

$LOAD_PATH.unshift (root/"lib").to_s
require 'sexpr'
require (root/"examples/bool_expr/bool_expr").to_s

def fixtures_path
  Path.dir/"../examples/bool_expr"
end

def bool_expr_parser
  BoolExpr.parser.parser
end