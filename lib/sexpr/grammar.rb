require_relative 'grammar/options'
require_relative 'grammar/matching'
require_relative 'grammar/parsing'
module Sexpr
  module Grammar
    include Options
    include Matching
    include Parsing

    def self.new(options = {})
      unless options.is_a?(Hash)
        raise ArgumentError, "Invalid grammar definition: #{options.inspect}"
      end
      Module.new.tap{|g|
        g.extend(Grammar)
        g.install_options(options)
      }
    end

  end # module Grammar
end # module Sexpr