require_relative 'grammar/options'
require_relative 'grammar/matching'
module Sexpr
  class Grammar
    include Options
    include Matching

    def initialize(options = {})
      unless options.is_a?(Hash)
        raise ArgumentError, "Invalid grammar definition: #{options.inspect}"
      end
      install_options(options)
    end

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

  end # class Grammar
end # module Sexpr