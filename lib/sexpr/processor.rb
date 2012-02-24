require_relative 'processor/helper'
require_relative 'processor/null_helper'
require_relative 'processor/sexpr_coercions'
module Sexpr
  class Processor

    class << self

      def preprocessors
        @preprocessors ||= superclass.preprocessors.dup rescue [ ]
      end

      def use(preprocessor)
        preprocessor.keys.each{|k| attr_reader(k)} if preprocessor.is_a?(Hash)
        preprocessors << preprocessor
      end

      def helpers
        @helpers ||= superclass.helpers.dup rescue [ ]
      end

      def helper(helper_class)
        methods = helper_class.const_get(:Methods) rescue nil
        module_eval{ include methods } if methods
        helpers << helper_class
      end

      def build_helper_chain(helpers = self.helpers)
        return NullHelper.new if helpers.empty?
        helpers[0...-1].reverse.inject(helpers.last.new) do |chain, h_class|
          prepended = h_class.new
          prepended.next_in_chain = chain
          prepended
        end
      end

    end # class << self

    attr_reader :options

    def initialize(options = {})
      @options = options
    end

    def call(sexpr)
      apply(preprocess(sexpr))
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

    def preprocess(sexpr)
      preprocessors = self.class.preprocessors
      preprocessors.each do |pre|
        sexpr = _preprocess(sexpr, pre)
      end
      sexpr
    end

    def _preprocess(sexpr, pre)
      if Hash===pre
        pre.each_pair do |k,v|
          self.instance_variable_set(:"@#{k}", v.new.call(sexpr))
        end
        sexpr
      else
        pre.new.call(sexpr)
      end
    end

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