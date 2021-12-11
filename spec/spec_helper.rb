require 'path'
root = Path.backfind('.[lib]')

require 'rspec'
require 'citrus'

$LOAD_PATH.unshift (root/"lib").to_s
require 'sexpr'
require (root/"examples/bool_expr/bool_expr").to_s

(Path.dir/:fixtures).glob("*.rb").each{|f| require f.without_extension}

def fixtures_path
  Path.dir/"../examples/bool_expr"
end

def bool_expr_parser
  BoolExpr.parser.parser
end

def sexpr(*args)
  Sexpr.sexpr(*args)
end