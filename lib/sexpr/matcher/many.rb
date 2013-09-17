module Sexpr
  module Matcher
    class Many
      include Matcher

      attr_reader :term, :min, :max

      def initialize(term, min, max = nil)
        @term       = term
        @min, @max  = minmax(min, max)
      end

      def match?(sexp)
        return nil unless sexp.is_a?(Array)
        eat = eat(sexp)
        eat && eat.empty?
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

      def parse(sexp, to = [])
        i, last, got = 0, sexp, []
        while sexp && (@max.nil? || i < @max)
          if res = @term.parse(sexp, got)
            last = res
            i += 1
          end
          sexp = res
        end
        if i >= @min
          got.each{|x| to << x }
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
  end # module Matcher
end # module Sexpr