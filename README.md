# Sexpr

A ruby compilation framework around s-expressions.

## Links

https://github.com/blambeau/sexpr

## Features/Problems

* Provides a YAML format for describing grammars (abstract syntax trees, more precisely).
* Provides a simple way to check the validity of a s-expression against a given grammar.
* Provides a framework for processing and rewriting abstract syntax trees.
* Focusses on the semantic pass, not the syntactic one.
* Smoothly, yet not tightly, integrates with the Citrus PEG parser (for the syntactic pass).

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

    Sexpr === expr
    # => true

    expr.sexpr_type
    # => :bool_lit

    expr.sexpr_body
    # => [true]

    # Rewriting s-expressions through copying is easy...
    copy = expr.sexpr_copy do |base,child|
      # copy a s-expression ala Enumerable#inject (base is [:bool_lit] initially)
      base << [:bool_lit, !child]
    end
    # => [:bool_lit, [:bool_lit, false]]

    # ... and is tag preserving (including User-included modules)
    Sexpr === copy
    # true

### Where to read next?

Have a look at the examples directory.

## Public API

`sexpr` uses Semver and reached 1.0. The public API is as follows:

* The structure of YAML grammar files
* The `Sexpr` module and its public methods
* The behavior of the `Grammar` class through its public methods
* The behavior of the `Node` class (public methods)
* The behavior of the `Processor` and `Rewriter` classes (public & protected methods)
* The list of error classes and when they are raised

## Contribute

Please use github issues and pull requests for all questions, bug reports,
and contributions. Don't hesitate to get in touch with us with an early code
spike if you plan to add non trivial features.

## Licence

This software is distributed by Enspirit SRL under a MIT Licence. Please
contact Bernard Lambeau (blambeau@gmail.com) with any question.

Enspirit (https://enspirit.be) and Klaro App (https://klaro.cards) are both
actively using and contributing to the library.
