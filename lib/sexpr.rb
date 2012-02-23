require 'yaml'
require_relative "sexpr/version"
require_relative "sexpr/loader"
require_relative "sexpr/errors"
require_relative "sexpr/node"
require_relative "sexpr/grammar"
require_relative "sexpr/matcher"
require_relative "sexpr/parser"
require_relative "sexpr/processor"
require_relative "sexpr/rewriter"
#
# A helper to manipulate sexp grammars
#
module Sexpr
  extend Grammar::Tagging

  PathLike = lambda{|x|
    x.respond_to?(:to_path) or (x.is_a?(String) and File.exists?(x))
  }

  def self.load(input, options = {})
    case input
    when PathLike then load_file   input, options
    when String   then load_string input, options
    when Hash     then load_hash   input, options
    else
      raise ArgumentError, "Invalid argument for Sexpr::Grammar: #{input}"
    end
  end

  def self.load_file(input, options = {})
    path = input.to_path rescue input.to_s
    load_hash YAML.load_file(path), options.merge(:path => input)
  end

  def self.load_string(input, options = {})
    load_hash YAML.load(input), options
  end

  def self.load_hash(input, options = {})
    raise ArgumentError, "Invalid grammar definition: #{input}" unless Hash===input
    Grammar.new input, options
  end

end # module Sexpr