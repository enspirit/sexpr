module Sexpr
  module Grammar
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
        yield self if block_given?
      end

      def option(key)
        @options[key.to_sym] || @options[key.to_s]
      end

      def install_path
        @path = option(:path)
      end

      def install_rules
        @rules = option(:rules) || {}
        @rules = compile_rules(@rules)
      end

      def install_root
        @root = option(:root)
        @root = rules.keys.first unless @root
        @root = root.to_sym if @root
      end

      def install_parser
        @parser = option(:parser)
        if @parser.is_a?(String) && !File.exists?(@parser)
          unless path
            raise Errno::ENOENT, "#{@parser} (no main path)"
          end
          @parser = File.join(File.dirname(path), @parser)
        end
        @parser = Parser.factor(@parser) if @parser
      end

      def compile_rules(rules)
        @rules = rules
      end

    end # module Options
  end # module Grammar
end # module Sexpr