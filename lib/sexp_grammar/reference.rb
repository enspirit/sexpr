module SexpGrammar
  class Reference
    include Element

    attr_reader :rule_name
    attr_reader :grammar

    def initialize(rule_name, grammar)
      @rule_name = rule_name
      @grammar   = grammar
    end

    def _match(sexp, matches)
      return nil unless rule = @grammar[@rule_name]
      rule._match(sexp, matches)
    end

  end # class Reference
end # module SexpGrammar