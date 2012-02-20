module SexpGrammar
  class Alternative
    include Element

    attr_reader :terms

    def initialize(terms)
      @terms = terms
    end

    def _match(sexp, matches)
      return nil if sexp.empty?
      @terms.each do |alt|
        res = alt._match(sexp, matches)
        return res if res
      end
      nil
    end

  end # class Alternative
end # module SexpGrammar