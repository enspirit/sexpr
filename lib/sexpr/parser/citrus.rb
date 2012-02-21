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

      def parse(input, options = {})
        input = input_text(input)
        @parser.parse(input, options)
      end

      Sexpr::Parser.register self
    end # class Citrus
  end # module Parser
end # module Sexpr