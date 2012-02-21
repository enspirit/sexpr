module Sexpr
  module Parser
    class Citrus
      include Parser

      def self.recognizes?(parser)
        defined?(::Citrus::Grammar) &&
        parser.is_a?(Module) &&
        parser.include?(::Citrus::Grammar)
      end

      attr_reader :options

      def initialize(parser, options = {})
        @parser  = parser
        @options = default_options.merge(options)
      end

      def default_options
        {:from_match_to_sexp => lambda{|match| match.value}}
      end

      def parse(input, options = {})
        input = input_text(input)
        @parser.parse(input, options)
      end

      Sexpr::Parser.register self
    end # class Citrus
  end # module Parser
end # module Sexpr