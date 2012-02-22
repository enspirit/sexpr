require 'spec_helper'
module Sexpr::Parser
  describe Citrus, "to_sexpr" do

    it 'calls value by default' do
      parser = Citrus.new(bool_expr_parser)
      parsed = parser.parse("true")
      parser.to_sexpr(parsed).should eq([:bool_lit, true])
    end

    it 'calls to_sexpr if it exists' do
      module BoolLitCoupon
        def to_sexpr
          [:hello, strip]
        end
      end
      parser = Citrus.new (::Citrus.eval <<-GRAMMAR).last
        grammar Test
          rule bool_lit
            "true" <Sexpr::Parser::BoolLitCoupon>
          end
        end
      GRAMMAR
      parsed = parser.parse("true")
      parser.to_sexpr(parsed).should eq([:hello, "true"])
    end

  end
end