require_relative 'foo'
class BarHelper < Sexpr::Processor::Helper
  module Methods
  end
end

class BarProcessor < FooProcessor
  helper BarHelper
end