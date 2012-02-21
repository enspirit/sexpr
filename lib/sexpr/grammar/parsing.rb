module Sexpr
  class Grammar
    module Parsing

      def parse(input, options = {})
        parser!.parse(input, options)
      end

      def to_sexpr(input, options = {})
        return input if input.is_a?(Array)
        parser!.to_sexpr(input, options)
      end

      private

      def parser!
        unless p = parser
          raise NoParserError, "No parser set.", caller
        end
        p
      end

    end # module Parsing
  end # class Grammar
end # module Sexpr