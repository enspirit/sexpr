module Sexpr
  module Matcher
    class Sequence
      include Matcher

      attr_reader :terms

      def initialize(terms)
        @terms = terms
      end

      def match?(sexp)
        return nil unless sexp.is_a?(Array)
        eat = eat(sexp)
        eat && eat.empty?
      end

      def eat(sexp)
        @terms.inject sexp do |rest,rule|
          rest && rule.eat(rest)
        end
      end

      def inspect
        "(seq #{terms.inspect})"
      end

    end # class Sequence
  end # module Matcher
end # module Sexpr