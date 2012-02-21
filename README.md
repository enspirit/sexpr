# Sexpr

A ruby compilation framework around s-expressions.

## Example

    # Let load a grammar defined in YAML
    grammar = SexpGrammar.load(<<-YAML)
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

### Checking the structure of s-expressions

    # the grammar can be used to verify the structure of s-expressions
    grammar === [:bool_and, [:bool_not, [:var_ref, "x"]], [:bool_lit, true]]
    # => true

    grammar === [:bool_and, [:bool_lit, "true"]]
    # => false (second term is missing)

### Including s-expression tools

    # the grammar can also be used to automatically have support on top of
    # such s-expressions
    expr = grammar.sexpr([:bool_lit, true])

    expr.sexpr_type
    # => :bool_lit

    expr.sexpr_body
    # => [true]

## Links

https://github.com/blambeau/sexpr