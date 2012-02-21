require_relative 'grammar/options'
require_relative 'grammar/matching'
require_relative 'grammar/parsing'
require_relative 'grammar/tagging'
module Sexpr
  module Grammar
    include Options
    include Matching
    include Parsing
    include Tagging

    def self.new(options = {})
      unless options.is_a?(Hash)
        raise ArgumentError, "Invalid grammar definition: #{options.inspect}"
      end
      Module.new.tap{|g|
        g.instance_eval{
          include(Grammar)
          extend(self)
          install_options(options)
        }
      }
    end

    def tagging_reference
      self
    end

  end # module Grammar
end # module Sexpr