module Sexpr
  module Parser
    class Citrus
      include Parser

      def self.recognizes?(parser)
        defined?(::Citrus::Grammar) &&
        parser.is_a?(Module) &&
        parser.include?(::Citrus::Grammar)
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
