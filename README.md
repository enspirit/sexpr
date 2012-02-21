# Sexpr

A ruby compilation framework around s-expressions.

## Example

    grammar = SexpGrammar.load(<<-YAML)
      rules:
        # alternative rule
        bool_expr:
          - bool_and
          - bool_or
          - bool_not
          - var_ref
          - literal

        # non-terminal
        bool_and:
          - [ bool_expr, bool_expr ]
        bool_or:
          - [ bool_expr, bool_expr ]
        bool_not:
          - [ bool_expr ]
        literal:
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

    grammar === [:bool_and, [:bool_not, [:var_ref, "x"]], [:literal, true]]
    # => true

    grammar === [:bool_and, [:literal, "true"]]
    # => false (second term is missing)

## Links

https://github.com/blambeau/sexpr
