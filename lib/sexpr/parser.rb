module Sexpr
  module Parser

    class << self

      def registered_parser_classes
        @registered_parser_classes ||= []
      end

      def register(parser_class)
        registered_parser_classes << parser_class
      end

      def find_parser_class(external_parser)
        registered_parser_classes.find{|cl|
          cl.recognizes?(external_parser)
        }
      end

      def factor(external_parser)
        return external_parser if Parser===external_parser
        if cl = find_parser_class(external_parser)
          cl.new(external_parser)
        else
          raise UnrecognizedParserError, "Parser not recognized: #{external_parser}"
        end
      end

    end # class methods

    private

    def input_text(input)
      case input
      when lambda{|x| x.respond_to?(:to_path)}
        input_text File.read(input.to_path)
      when IO
        input_text input.read
      when String
        input
      else
        raise InvalidParseSourceError, "Invalid parse source: #{input}"
      end
    end

  end # module Parser
end # module Sexpr
require_relative "parser/citrus"
