$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'epath'
require 'sexpr'

def fixtures_path
  Path.dir/"../examples/bool_expr"
end

require 'citrus'
::Citrus.load (fixtures_path/"bool_expr").to_s