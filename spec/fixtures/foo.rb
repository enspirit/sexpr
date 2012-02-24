class FooHelper < Sexpr::Processor::Helper
  module Methods
  end

  def on_hello(rw, sexpr)
    raise unless rw.is_a?(FooProcessor)
    [:foo_hello, yield(rw, sexpr)]
  end

end

class FooProcessor < Sexpr::Processor
  helper FooHelper
end