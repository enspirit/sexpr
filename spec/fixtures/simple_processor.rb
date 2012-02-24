class SimpleProcessor < Sexpr::Processor

  def on_hello(sexpr)
    [:simple_hello, sexpr]
  end

  def on_missing(sexpr)
    if sexpr.first == :simple_missing
      [:simple_pass_missing, sexpr]
    else
      super
    end
  end

  def on_apply(sexpr)
    apply(sexpr.last)
  end

end