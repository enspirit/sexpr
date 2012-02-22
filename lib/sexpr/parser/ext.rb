module Citrus
  class Match

    def sexpr
      Sexpr.sexpr(value, {:citrus_match => self})
    end

  end
end