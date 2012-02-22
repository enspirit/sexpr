# 0.4.0 / FIX ME

* Breaking changes

  * `Parser.factor` does no longer accept options. This is to avoid the 'yet another options'
    symptom and favor convention over configuration.
  * Accordingly, the Citrus::Parser no longer takes options at construction either.

# 0.3.0 / 2012-02-21

* Breaking changes

  * `Sexpr.load` only takes one argument, merging both the rules and the options inside a
    unique Hash object (or something coercible to a Hash, such as YAML).
  * The YAML grammar format now requires rules to be specified under a "rules" entry. See
    the README for an example.

* Major enhancements

  * A lexical parser can now be specified under a "parser" entry. Only Citrus is supported
    for now.
  * A loaded grammar (i.e. returned by `Sexpr.load`) is now a module. Therefore assigning
    the result to a constant makes perfect sense and benefits from the ruby's magic naming
    feature.
  * A loaded grammar now respond to a :sexpr method that parses (if needed) and returns a
    s-expression. The latter, and all its sub-expressions are automatically tagged with the
    Sexpr module, as well as with user-defined modules. The latter are automatically discovered
    with a convention over configuration heuristics that associates rule names to module names.
    That convention may however be overridden with specific grammar methods (see the BoolExpr
    example).

# 0.2.0 / 2012-02-21

* Enhancements

  * The project has been renamed as Sexpr instead of SexpGrammar
  * The root rule to use can now be specified in the options hash taken as second argument
    of `SexpGrammar.grammar(..., :root => :some_rule_name)`

# 0.1.0 / 2012-02-20

* Enhancements

  * Birthday!