module Sexpr
  module Grammar
    module Matching

      def root_rule
        rules[root]
      end

      def [](rule_name)
        rules[rule_name]
      end

      def match?(sexp)
        root_rule.match?(sexp)
      end
      alias :=== :match?

    private

      def compile_rules(rules)
        Hash[rules.map{|k,v|
          [k.to_sym, compile_rule(k.to_sym, v)]
        }]
      end

      def compile_rule(name, defn)
        case rule = compile_rule_defn(defn)
        when Matcher::Terminal, Matcher::Alternative
          rule
        else
          Matcher::Rule.new(name, rule)
        end
      end

      def compile_rule_defn(arg, grammar = self)
        case arg
        when Matcher
          arg
        when Regexp, Module
          Matcher::Terminal.new arg
        when TrueClass, FalseClass, NilClass
          Matcher::Terminal.new arg
        when lambda{|x| x.is_a?(Array) && x.size == 1 && x.first.is_a?(Array)}
          Matcher::Sequence.new arg.first.map{|s| compile_rule_defn(s) }
        when Array
          Matcher::Alternative.new arg.map{|s| compile_rule_defn(s)}
        when /([\?\+\*])$/
          Matcher::Many.new compile_rule_defn($`), $1
        when /^[a-z][a-z_]+$/
          Matcher::Reference.new arg.to_sym, grammar
        when /^::([A-Z][a-z]*.*)$/
          found = $1.split('::').inject(Kernel){|cl,n| cl.const_get(n)}
          Matcher::Terminal.new found
        else
          raise ArgumentError, "Invalid rule definition: #{arg.inspect}", caller
        end
      end

    end # module Matching
  end # module Grammar
end # module Sexpr