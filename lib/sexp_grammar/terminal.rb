module SexpGrammar
  class Terminal
    include Element

    attr_reader :value

    def initialize(value)
      @value = value
    end

    def inspect
      "(terminal #{value.inspect})"
    end

    def match?(sexp)
      terminal_match?(sexp)
    end
    alias :=== :match?

    def _match(sexp, matches)
      return nil if sexp.empty?
      return nil unless terminal_match?(sexp.first)
      (matches[self] ||= []) << sexp.first
      sexp[1..-1]
    end

    private

    def terminal_match?(term)
      case @value
      when Regexp
        @value === term rescue false
      when TrueClass, FalseClass, NilClass
        @value == term
      end
    end

  end # class Terminal
end # module SexpGrammar