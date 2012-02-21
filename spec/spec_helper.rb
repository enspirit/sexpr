$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'epath'
require 'sexpr'

require 'citrus'
::Citrus.load (Path.dir/"fixtures/bool_expr").to_s
