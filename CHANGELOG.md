# 0.3.0 / FIX ME

* Breaking changes

  * `Sexpr.load` only takes one argument, merging both the rules and the options inside a
    unique Hash object (or something coercible to a Hash, such as YAML).
  * The YAML grammar format now requires rules to be specified under a "rules" entry. See
    the README for an example.

* Major enhancements

  * A lexical parser can now be specified under a "parser" entry. Only Citrus is supported
    for now

# 0.2.0 / 2012-02-21

* Enhancements

  * The project has been renamed as Sexpr instead of SexpGrammar
  * The root rule to use can now be specified in the options hash taken as second argument
    of `SexpGrammar.grammar(..., :root => :some_rule_name)`

# 0.1.0 / 2012-02-20

* Enhancements

  * Birthday!