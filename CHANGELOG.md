# 0.2.0 / 2012-02-21

* Enhancements (including breaking features)

  * The project has been renamed as Sexpr instead of SexpGrammar
  * `Sexpr.load` only takes one argument, merging both the rules and the options inside a
    unique Hash object (or something coercible to a Hash, such as YAML)
  * The YAML grammar format now requires rules to be specified under a "rules" entry. See
    the README for an example.
  * The root rule to use can now be specified under a "root" entry
  * A lexical parser can now be specified under a "parser" entry. Only Citrus is supported
    for now

# 0.1.0 / 2012-02-20

* Enhancements

  * Birthday!
