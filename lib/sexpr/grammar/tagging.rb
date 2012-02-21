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

      def sexpr(input, options = {})
        case input
        when Array
          tag_sexpr input
        else
          tag_sexpr parser!.sexpr(input, options)
        end
      end

      private

      def tag_sexpr(sexpr, reference = self)
        if sexpr.is_a?(Array) and sexpr.first.is_a?(Symbol)
          sexpr.extend(Sexpr)
          rulename = sexpr.first
          modname  = rule2modname(rulename)
          mod      = reference.const_get(modname) rescue nil
          mod ? sexpr.extend(mod) : sexpr
        else
          sexpr
        end
      end

    end # module Tagging
  end # module Grammar
end # module Sexpr