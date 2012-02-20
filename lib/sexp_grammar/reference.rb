module SexpGrammar
  class Reference
    include Element

    attr_reader :rule_name
    attr_reader :grammar

    def initialize(rule_name, grammar)
      @rule_name = rule_name
      @grammar   = grammar
    end

    def rule
      @rule ||= @grammar[@rule_name]
    end

    def match?(sexp)
      rule && rule.match?(sexp)
    end
    alias :=== :match?

    def _match(sexp, matches)
      rule && rule._match(sexp, matches)
    end

    def inspect
      "(ref #{rule_name}, #{rule.inspect})"
    end

  end # class Reference
end # module SexpGrammar