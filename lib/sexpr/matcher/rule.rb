module Sexpr
  module Matcher
    class Rule
      include Matcher

      attr_reader :name
      attr_reader :defn

      def initialize(name, defn)
        @name = name
        @defn = defn
      end

      def match?(sexp)
        return nil unless sexp.is_a?(Array)
        return false unless sexp.first && (sexp.first == name)
        defn.match?(sexp[1..-1])
      end

      def eat(sexp)
        return nil unless match?(sexp.first)
        sexp[1..-1]
      end

      def inspect
        "(rule #{name}, #{defn.inspect})"
      end

    end # class Rule
  end # module Matcher
end # module Sexpr
