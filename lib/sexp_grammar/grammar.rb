module SexpGrammar
  class Grammar

    attr_reader :rules

    def initialize(rules = {})
      @rules = compile_rules(rules)
    end

    def [](rule_name)
      @rules[rule_name]
    end

    private

    def compile_rules(rules)
      Hash[rules.map{|k,v|
        [k.to_sym, compile_rule(k.to_sym, v)]
      }]
    end

    def compile_rule(name, defn)
      case rule = compile_rule_defn(defn)
      when Terminal, Alternative
        rule
      else
        Rule.new(name, rule)
      end
    end

    def compile_rule_defn(arg)
      case arg
      when Regexp, TrueClass, FalseClass, NilClass
        Terminal.new arg
      when lambda{|x| x.is_a?(Array) && x.size == 1 && x.first.is_a?(Array)}
        Sequence.new arg.first.map{|s| compile_rule_defn(s) }
      when Array
        Alternative.new arg.map{|s| compile_rule_defn(s)}
      when /([\?\+\*])$/
        Many.new compile_rule_defn($`), $1
      when /^[a-z][a-z_]+$/
        Reference.new arg.to_sym, self
      when lambda{|x| x.respond_to?(:_match)}
        arg
      else
        raise ArgumentError, "Invalid rule definition: #{arg.inspect}", caller
      end
    end

  end # class Grammar
end # module SexpGrammar