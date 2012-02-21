require_relative 'grammar/options'
require_relative 'grammar/matching'
require_relative 'grammar/parsing'
module Sexpr
  class Grammar

    def self.new(options = {})
      unless options.is_a?(Hash)
        raise ArgumentError, "Invalid grammar definition: #{options.inspect}"
      end
      Module.new.tap{|g|
        g.extend(Options)
        g.extend(Matching)
        g.extend(Parsing)
        g.install_options(options)
      }
    end

  end # class Grammar
end # module Sexpr