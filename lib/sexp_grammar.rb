require_relative "sexp_grammar/version"
require_relative "sexp_grammar/loader"
#
# A helper to manipulate sexp grammars
#
module SexpGrammar

  def self.load(input)
    case input
    when lambda{|x| x.respond_to?(:to_path)}
      load(YAML.load_file input.to_path)
    when String
      load(YAML.load input)
    when Hash
      Grammar.new(input)
    else
      raise ArgumentError, "Invalid argument for SexpUtils::Grammar: #{input}"
    end
  end

end # module SexpGrammar
require_relative "sexp_grammar/grammar"