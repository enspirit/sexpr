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

      def default_tagging_module
        nil
      end

      def sexpr(input, markers = nil)
        case input
        when Array
          tag_sexpr input, markers
        else
          sexpr = parser!.to_sexpr(parse(input))
          tag_sexpr sexpr, markers, true
        end
      end

      private

      def tag_sexpr(sexpr, markers = nil, force = false)
        return sexpr unless looks_a_sexpr?(sexpr)
        return sexpr if Sexpr===sexpr and not(force) and markers.nil?

        # set the Sexpr modules
        sexpr.extend(Sexpr) unless Sexpr===sexpr
        tag_sexpr_with_user_module(sexpr)

        # set the markers if any
        if markers
          markers = sexpr.tracking_markers.merge(markers) if Sexpr===sexpr
          sexpr.tracking_markers = markers
        end

        # recurse
        sexpr[1..-1].each do |child|
          tag_sexpr(child, nil, force)
        end
        sexpr
      end

      def tag_sexpr_with_user_module(sexpr)
        if ref = tagging_reference
          rulename = sexpr.first
          modname  = rule2modname(rulename)
          tag      = ref.const_get(modname, false) rescue default_tagging_module
          sexpr.extend(tag) if tag
        elsif tag = default_tagging_module
          sexpr.extend(tag)
        end
        sexpr
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