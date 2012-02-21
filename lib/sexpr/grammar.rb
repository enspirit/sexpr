module Sexpr
  class Grammar

    attr_reader :rules
    attr_reader :root
    attr_reader :parser

    def initialize(rules = {}, options = {})
      compile_rules(rules)
      install_options(options)
    end

    def [](rule_name)
      @rules[rule_name]
    end

    def parse(input)
      raise NoParserError, "No parser set." unless parser
      parser.parse(input)
    end

    def match?(sexp)
      root.match?(sexp)
    end
    alias :=== :match?

    private

    def install_options(options)
      install_root_option(options)
      install_parser_option(options)
    end

    def install_root_option(options)
      @root = options[:root] || rules.keys.first
      @root = self[@root] if @root.is_a?(Symbol)
    end

    def install_parser_option(options)
      @parser = if options.has_key?(:parser)
        Parser.factor(options[:parser])
      else
        nil
      end
    end

    def compile_rules(rules)
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