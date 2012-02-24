class Preprocessed < Sexpr::Processor

  class Prefix < Sexpr::Processor

    def on_missing(sexpr)
      [ :"#{options[:prefix]}#{sexpr.first}" ] + sexpr[1..-1]
    end

  end
  use Prefix, :prefix => "prefix_"

  def on_prefix_hello(sexpr)
    [:preprocessed_hello, sexpr]
  end

  def on_apply(sexpr)
    apply(sexpr.last)
  end

end

class SubPreprocessed < Preprocessed

  class Upcase < Sexpr::Processor

    def call(sexpr)
      sexpr.first.to_s.upcase
    end

  end
  use :upcased => Upcase

end