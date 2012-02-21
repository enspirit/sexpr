module Sexpr
  module Parser
    class Citrus
      include Parser

      class << self

        def new(arg, options = {})
          if looks_a_citrus_grammar?(arg)
            super(arg, options)
          elsif looks_a_citrus_file?(arg)
            arg = arg.to_path if arg.respond_to?(:to_path)
            arg = arg[0...-(".citrus".length)]
            super(::Citrus.load(arg).last, options)
          else
            nil
          end
        end

        def recognizes?(arg)
          looks_a_citrus_grammar?(arg) or
          looks_a_citrus_file?(arg)
        end

        def looks_a_citrus_file?(arg)
          arg = arg.to_path if arg.respond_to?(:to_path)
          arg.is_a?(String) && File.exists?(arg) && (File.extname(arg) == ".citrus")
        end

        def looks_a_citrus_grammar?(arg)
          defined?(::Citrus::Grammar) && arg.is_a?(Module) && arg.include?(::Citrus::Grammar)
        end

      end # class << self

      attr_reader :parser
      attr_reader :options

      def initialize(parser, options = {})
        @parser  = parser
        @options = default_options.merge(options)
      end

      def default_options
        {:from_match_to_sexpr => lambda{|match| match.value}}
      end

      def parse(input, options = {})
        input = input_text(input)
        @parser.parse(input, options)
      end

      def to_sexpr(input, parse_options = {})
        from_match_to_sexpr parse(input, parse_options)
      end

      private

      def from_match_to_sexpr(match)
        options[:from_match_to_sexpr].call(match)
      end

      Sexpr::Parser.register self
    end # class Citrus
  end # module Parser
end # module Sexpr