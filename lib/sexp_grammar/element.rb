module SexpGrammar
  module Element

    def match?(sexp)
      return nil unless sexp.is_a?(Array)
      m = _match(sexp, {})
      m && m.empty?
    end
    alias :=== :match?

  end # module SexpGrammar
end # module SexpGrammar