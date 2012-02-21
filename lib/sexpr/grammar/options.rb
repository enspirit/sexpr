module Sexpr
  class Grammar
    module Options

      attr_reader :options
      attr_reader :path
      attr_reader :rules
      attr_reader :root
      attr_reader :parser

      def install_options(options)
        @options = options
        install_path
        install_rules
        install_root
        install_parser
      end

      def option(key)
        @options[key.to_sym] || @options[key.to_s]
      end

      def install_path
        @path = option(:path)
      end

      def install_rules
        @rules = compile_rules(option(:rules) || {})
      end

      def install_root
        @root = option(:root)
        @root = rules.keys.first unless @root
        @root = self[@root] if @root.is_a?(Symbol)
      end

      def install_parser
        @parser = option(:parser)
        if @parser.is_a?(String) && !File.exists?(@parser)
          @parser = File.join(File.dirname(path), @parser)
        end
        @parser = Parser.factor(@parser) if @parser
      end

    end # module Options
  end # class Grammar
end # module Sexpr