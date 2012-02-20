module SexpGrammar
  class Rule
    include Element

    attr_reader :name

    def initialize(name, defn)
      @name = name
      @defn = defn
    end

    def _match(sexp, matches)
      return nil unless sexp.first == name
      @defn._match(sexp[1..-1], matches)
    end

  end # class Rule
end # module SexpGrammar