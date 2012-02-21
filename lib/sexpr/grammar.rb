module Sexpr
  class Grammar

    attr_reader :rules
    attr_reader :root
    attr_reader :parser

    def initialize(rules = {}, options = {})
      install(options.merge(:rules => rules))
    end

    def [](rule_name)
      @rules[rule_name]
    end

    def parse(input, options = {})
      parser!.parse(input, options)
    end

    def to_sexpr(input, options = {})
      return input if input.is_a?(Array)
      parser!.to_sexpr(input, options)
    end

    def match?(sexp)
      root.match?(sexp)
    end
    alias :=== :match?

    private

    def parser!
      unless p = parser
        raise NoParserError, "No parser set.", caller
      end
      p
    end

    def install(options)
      install_rules  options
      install_root   options
      install_parser options
    end

    def install_root(options)
      @root = options[:root]
      @root = rules.keys.first unless @root
      @root = self[@root] if @root.is_a?(Symbol)
    end

    def install_parser(options)
      @parser = options[:parser]
      @parser = Parser.factor(@parser) if @parser
    end

    def install_rules(options)
      @rules = options[:rules] || {}
      @rules = Hash[rules.map{|k,v|
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