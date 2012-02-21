require_relative 'grammar/options'
require_relative 'grammar/matching'
require_relative 'grammar/parsing'
module Sexpr
  class Grammar
    include Options
    include Matching
    include Parsing

    def initialize(options = {})
      unless options.is_a?(Hash)
        raise ArgumentError, "Invalid grammar definition: #{options.inspect}"
      end
      install_options(options)
    end

  end # class Grammar
end # module Sexpr