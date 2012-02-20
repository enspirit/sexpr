module SexpGrammar
  class Many
    include Element

    attr_reader :term, :min, :max

    def initialize(term, min, max = nil)
      @term       = term
      @min, @max  = minmax(min, max)
    end

    def eat(sexp)
      i, last = 0, sexp
      while sexp && (@max.nil? || i < @max)
        if res = @term.eat(sexp)
          last = res
          i += 1
        end
        sexp = res
      end
      i >= @min ? last : nil
    end

    def _match(sexp, matches)
      match_backup, i = matches.dup, 0
      last = sexp
      while sexp && (@max.nil? || i < @max)
        if res = @term._match(sexp, match_backup)
          last = res
          i += 1
        end
        sexp = res
      end
      if i >= @min
        matches.merge!(match_backup)
        last
      end
    end

    def inspect
      "(many #{term.inspect}, #{min}, #{max})"
    end

    private

    def minmax(min, max)
      case min
      when Integer
        [min, max]
      when '?'
        [0, 1]
      when '+'
        [1, nil]
      when '*'
        [0, nil]
      else
        raise ArgumentError, "Invalid multiplicity: #{min}"
      end
    end

  end # class Sequence
end # module SexpGrammar