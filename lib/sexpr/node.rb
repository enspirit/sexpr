module Sexpr
  module Node

    EMPTY_TRACKING_MARKERS = {}

    def tracking_markers
      @tracking_markers ||= EMPTY_TRACKING_MARKERS
    end

    def tracking_markers=(markers)
      @tracking_markers = markers
    end

    def sexpr_type
      first
    end
    alias :sexp_type :sexpr_type

    def sexpr_body
      self[1..-1]
    end
    alias :sexp_body :sexpr_body

    def sexpr_copy(&block)
      if block
        copy = sexpr_copy_tagging([ sexpr_type ])
        sexpr_body.inject(copy, &block)
      else
        sexpr_copy_tagging(self[0..-1])
      end
    end
    alias :dup :sexpr_copy

    private

    def sexpr_copy_tagging(copy)
      (class << self; self; end).included_modules.each do |mod|
        copy.extend(mod) unless mod === copy
      end
      copy.tracking_markers = tracking_markers
      copy
    end

  end # module Node
  include Node
end # module Sexpr