module Sexpr
  module Grammar
    module Tagging

      def rule2modname(rule)
        rule.to_s.gsub(/(^|_)([a-z])/){|x| $2.capitalize}.to_sym
      end

      def mod2rulename(mod)
        mod = mod.name.to_s.split('::').last.to_sym if mod.is_a?(Module)
        mod.to_s.gsub(/[A-Z]/){|x| "_#{x.downcase}"}[1..-1].to_sym
      end

      def tagging_reference
        nil
      end

      def sexpr(input, markers = nil)
        case input
        when Array
          tag_sexpr input, tagging_reference, markers
        else
          if markers
            raise NotImplementedError, "Unable to set markers while parsing"
          end
          sexpr = parser!.to_sexpr(parse(input))
          tag_sexpr sexpr, tagging_reference, markers, true
        end
      end

      private

      def tag_sexpr(sexpr, reference, markers = nil, force = false)
        return sexpr if Sexpr === sexpr and not(force)
        return sexpr unless looks_a_sexpr?(sexpr)

        # set the Sexpr modules
        sexpr.extend(Sexpr)
        tag_sexpr_with_user_module(sexpr, reference) if reference

        # set the markers if any
        sexpr.tracking_markers = markers if markers

        # recurse
        sexpr[1..-1].each do |child|
          tag_sexpr(child, reference, nil, force)
        end
        sexpr
      end

      def tag_sexpr_with_user_module(sexpr, reference)
        rulename = sexpr.first
        modname  = rule2modname(rulename)
        mod      = reference.const_get(modname) rescue nil
        sexpr.extend(mod) if mod
      end

      def looks_a_sexpr?(arg)
        arg.is_a?(Array) and arg.first.is_a?(Symbol)
      end

      def parser!
        raise NoParserError, "No parser set.", caller
      end

    end # module Tagging
  end # module Grammar
end # module Sexpr