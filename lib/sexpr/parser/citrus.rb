module Sexpr
  module Parser
    class Citrus
      include Parser

      def self.===(p)
        defined?(::Citrus::Grammar) &&
        (::Citrus::Grammar===p)
      end

      def initialize(parser)
        @parser = parser
      end

      def parse(source, options = {})
        @parser.parse(source, options)
      end

    end # class Citrus
  end # module Parser
end # module Sexpr
