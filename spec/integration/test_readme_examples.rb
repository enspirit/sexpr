require 'spec_helper'
describe "the README examples" do

  it 'works as announced' do

    grammar = Sexpr.load(<<-YAML)
      rules:
        # alternative rule
        bool_expr:
          - bool_and
          - bool_or
          - bool_not
          - var_ref
          - bool_lit

        # non-terminal
        bool_and:
          - [ bool_expr, bool_expr ]
        bool_or:
          - [ bool_expr, bool_expr ]
        bool_not:
          - [ bool_expr ]
        bool_lit:
          - [ truth_value ]
        var_ref:
          - [ var_name ]

        # terminals
        var_name:
          !ruby/regexp /^[a-z]+$/
        truth_value:
          - true
          - false
    YAML

    # the grammar can be used to verify the structure of s-expressions
    f = (grammar === [:bool_and, [:bool_not, [:var_ref, "x"]], [:bool_lit, true]])
    f.should be_truthy

    f = (grammar === [:bool_and, [:bool_lit, "true"]])
    f.should be_falsey

    # the grammar can also be used to automatically have support on top of
    # such s-expressions
    expr = grammar.sexpr([:bool_lit, true])
    (Sexpr===expr).should be_truthy

    (expr.sexpr_type).should eq(:bool_lit)
    # => :bool_lit

    (expr.sexpr_body).should eq([true])
    # => [true]

    copy = expr.sexpr_copy do |base,child|
      # copy a s-expression ala Enumerable#inject (base is [:bool_lit] initially)
      base << [:bool_lit, !child]
    end
    copy.should eq([:bool_lit, [:bool_lit, false]])
    # => [:bool_lit, [:bool_lit, false]]

    (Sexpr===copy).should be_truthy

  end

end