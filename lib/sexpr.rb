require_relative "sexpr/version"
require_relative "sexpr/loader"
require_relative "sexpr/errors"
require_relative "sexpr/node"
require_relative "sexpr/grammar"
require_relative "sexpr/matcher"
require_relative "sexpr/parser"
#
# A helper to manipulate sexp grammars
#
module Sexpr
  extend Grammar::Tagging

  PathLike = lambda{|x|
    x.respond_to?(:to_path) or (x.is_a?(String) and File.exists?(x))
  }

  def self.load(input)
    defn = case input
            when PathLike
              require 'yaml'
              path = input.respond_to?(:to_path) ? input.to_path : input.to_s
              YAML.load_file(path).merge(:path => input)
            when String
              require 'yaml'
              YAML.load(input)
            when Hash
              input
            else
              raise ArgumentError, "Invalid argument for Sexpr::Grammar: #{input}"
            end
    Grammar.new defn
  end

end # module Sexpr