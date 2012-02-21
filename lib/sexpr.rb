require_relative "sexpr/version"
require_relative "sexpr/loader"
#
# A helper to manipulate sexp grammars
#
module Sexpr

  def self.load(input, options = {})
    case input
    when lambda{|x| x.respond_to?(:to_path)}
      require 'yaml'
      load(YAML.load_file(input.to_path), options)
    when String
      require 'yaml'
      load(YAML.load(input), options)
    when Hash
      Grammar.new(input, options)
    else
      raise ArgumentError, "Invalid argument for Sexpr::Grammar: #{input}"
    end
  end

end # module Sexpr
require_relative "sexpr/grammar"
require_relative "sexpr/matcher"
