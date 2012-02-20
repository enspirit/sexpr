module SexpGrammar
  class Sequence
    include Element

    attr_reader :terms

    def initialize(terms)
      @terms = terms
    end

    def _match(sexp, matches)
      match_backup = matches.dup
      result = @terms.inject sexp do |rest,rule|
        rest && rule._match(rest, match_backup)
      end
      matches.merge!(match_backup) if result
      result
    end

  end # class Sequence
end # module SexpGrammar