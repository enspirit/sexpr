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

      def to_sexpr(input, options = {})
        return input if input.is_a?(Array)
        tag_sexpr parser!.to_sexpr(input, options)
      end

      private

      def tag_sexpr(sexpr, reference = self)
        if sexpr.is_a?(Array) and sexpr.first.is_a?(Symbol)
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