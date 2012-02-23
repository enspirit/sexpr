require 'epath'
root = Path.backfind('.[lib]')

require 'citrus'

$LOAD_PATH.unshift (root/"lib").to_s
require 'sexpr'
require (root/"examples/bool_expr/bool_expr").to_s

class FooHelper < Sexpr::Processor::Helper
  module Methods
  end

  def on_hello(rw, node)
    raise unless rw.is_a?(FooProcessor)
    [:foo_hello, yield(rw, node)]
  end

end
class FooProcessor < Sexpr::Processor
  helper FooHelper
end

class BarHelper < Sexpr::Processor::Helper
  module Methods
  end
end
class BarProcessor < FooProcessor
  helper BarHelper
end

def fixtures_path
  Path.dir/"../examples/bool_expr"
end

def bool_expr_parser
  BoolExpr.parser.parser
end

def sexpr(*args)
  Sexpr.sexpr(*args)
end