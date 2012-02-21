module Sexpr
  module Matcher
    class Alternative
      include Matcher

      attr_reader :terms

      def initialize(terms)
        @terms = terms
      end

      def match?(sexp)
        terms.any?{|t| t.match?(sexp)}
      end

      def eat(sexp)
        @terms.each do |alt|
          res = alt.eat(sexp)
          return res if res
        end
        nil
      end

      def inspect
        "(alt #{terms.inspect})"
      end

    end # class Alternative
  end # module Matcher
end # module Sexpr