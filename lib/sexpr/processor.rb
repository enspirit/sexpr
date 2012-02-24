require_relative 'processor/helper'
require_relative 'processor/null_helper'
require_relative 'processor/sexpr_coercions'
module Sexpr
  class Processor

    ### class methods

    def self.helpers
      @helpers ||= superclass.helpers.dup rescue [ ]
    end

    def self.helper(helper_class)
      methods = helper_class.const_get(:Methods) rescue nil
      module_eval{ include methods } if methods
      helpers << helper_class
    end

    def self.build_helper_chain(helpers = self.helpers)
      return NullHelper.new if helpers.empty?
      helpers[0...-1].reverse.inject(helpers.last.new) do |chain, h_class|
        prepended = h_class.new
        prepended.next_in_chain = chain
        prepended
      end
    end

    ### instance methods

    attr_reader :main_processor

    def initialize(options = {})
      @main_processor = options.delete(:main_processor) || self
    end

    def call(sexpr)
      apply(sexpr)
    end

    def apply(sexpr)
      help(sexpr) do |n|
        meth = :"on_#{n.first}"
        meth = :"on_missing" unless respond_to?(meth)
        send(meth, n)
      end
    end

    def on_missing(sexpr)
      raise UnexpectedSexprError, "Unexpected sexpr: #{sexpr.inspect}"
    end

    private

    def helper_chain
      @helper_chain ||= self.class.build_helper_chain
    end

    def help(sexpr)
      helper_chain.call(self, sexpr) do |_,n|
        yield(n)
      end
    end

  end # class Processor
end # module Sexpr