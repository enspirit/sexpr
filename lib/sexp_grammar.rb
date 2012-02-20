require_relative "sexp_grammar/version"
require_relative "sexp_grammar/loader"
#
# A helper to manipulate sexp grammars
#
module SexpGrammar

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
      raise ArgumentError, "Invalid argument for SexpGrammar::Grammar: #{input}"
    end
  end

end # module SexpGrammar
require_relative "sexp_grammar/grammar"
require_relative "sexp_grammar/element"
require_relative "sexp_grammar/alternative"
require_relative "sexp_grammar/many"
require_relative "sexp_grammar/reference"
require_relative "sexp_grammar/rule"
require_relative "sexp_grammar/sequence"
require_relative "sexp_grammar/terminal"