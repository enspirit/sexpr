module Sexpr
  module Grammar
    module Parsing

      def parse(input, options = {})
        parser!.parse(input, options)
      end

      private

      def parser!
        unless p = parser
          raise NoParserError, "No parser set.", caller
        end
        p
      end

    end # module Parsing
  end # module Grammar
end # module Sexpr