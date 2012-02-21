module Sexpr
  module Parser
    class Citrus
      include Parser

      class << self

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

      attr_reader :options

      def initialize(parser, options = {})
        @parser  = parser
        @options = default_options.merge(options)
      end

      def default_options
        {:from_match_to_sexpr => lambda{|match| match.value}}
      end

      def parser
        @citrus_parser ||= begin
          if self.class.looks_a_citrus_grammar?(@parser)
            @parser
          elsif self.class.looks_a_citrus_file?(@parser)
            @parser = @parser.to_path if @parser.respond_to?(:to_path)
            @parser = @parser[0...-(".citrus".length)]
            ::Citrus.load(@parser).last
          else
            raise UnrecognizedParserError, "Not a citrus parser #{@parser}"
          end
        end
      end

      def parse(input, options = {})
        input = input_text(input)
        parser.parse(input, options)
      end

      def sexpr(input, parse_options = {})
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