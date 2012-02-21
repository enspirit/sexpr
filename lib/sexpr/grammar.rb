module Sexpr
  class Grammar

    attr_reader :rules, :options

    def initialize(rules = {}, options = {})
      @rules   = compile_rules(rules)
      @options = options
    end

    def [](rule_name)
      @rules[rule_name]
    end

    def root
      @root ||= begin
        root = options[:root] || rules.keys.first
        root = self[root] if root.is_a?(Symbol)
      end
    end

    def parser
      options[:parser]
    end

    def parse(input)
      case input
      when lambda{|x| x.respond_to?(:to_path)}
        parse(File.read(input.to_path))
      when IO
        parse(input.read)
      when String
        unless p = parser
          raise NoParserError, "No parser set.", caller
        end
        p.parse(input).value
      end
    end

    def match?(sexp)
      root.match?(sexp)
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

    def compile_rule_defn(arg)
      case arg
      when Matcher
        arg
      when Regexp, TrueClass, FalseClass, NilClass
        Matcher::Terminal.new arg
      when lambda{|x| x.is_a?(Array) && x.size == 1 && x.first.is_a?(Array)}
        Matcher::Sequence.new arg.first.map{|s| compile_rule_defn(s) }
      when Array
        Matcher::Alternative.new arg.map{|s| compile_rule_defn(s)}
      when /([\?\+\*])$/
        Matcher::Many.new compile_rule_defn($`), $1
      when /^[a-z][a-z_]+$/
        Matcher::Reference.new arg.to_sym, self
      else
        raise ArgumentError, "Invalid rule definition: #{arg.inspect}", caller
      end
    end

  end # class Grammar
end # module Sexpr