module Sexpr
  module Matcher

    def ===(sexp)
      match?(sexp)
    end

  end # module Matcher
end # module Sexpr
require_relative "matcher/alternative"
require_relative "matcher/many"
require_relative "matcher/reference"
require_relative "matcher/rule"
require_relative "matcher/sequence"
require_relative "matcher/terminal"