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

    end # module Tagging
  end # module Grammar
end # module Sexpr