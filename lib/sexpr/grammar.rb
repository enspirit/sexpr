require_relative 'grammar/options'
require_relative 'grammar/matching'
require_relative 'grammar/parsing'
require_relative 'grammar/tagging'
module Sexpr
  module Grammar
    include Options
    include Matching
    include Tagging
    include Parsing

    def self.new(input = {}, options = {})
      Module.new.tap{|g|
        g.instance_eval{
          include(Grammar)
          extend(self)
          install_options(input.merge(options))
        }
      }
    end

    def tagging_reference
      self
    end

  end # module Grammar
end # module Sexpr