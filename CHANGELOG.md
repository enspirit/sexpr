# 0.4.0 / 2012-02-23

* Major enhancements

  * A processing/rewriting framework has been added to Sexpr. See the `Processor` and `Rewriter`
    classes, as well as the boolean expression example.
  * Tracking markers can now decorate s-expressions, provided they include the `Sexpr` module.
    Tracking markers are a simple Hash of meta-information (i.e. not taken into account for
    equality for s-expressions). Such markers can be set with `Grammar#sexpr(sexpr, markers)`.
    Default markers are typically provided by parsers for traceability of the s-expression
    with the source text it comes from.

* Minor enhancements

  * `Citrus::Parser#parse` is now idempotent and so is `Grammar#parse` therefore.
  * The module to use for finding tag modules through `const_get` can now be overridden in
    `Grammar#tagging_reference`.
  * Default parsing options can now be specified in `Grammar#default_parse_options`. These
    options are used by `Grammar#sexpr` when parsing is needed.

* Breaking changes

  * `Parser.factor` does no longer accept options. This is to avoid the 'yet another options'
    symptom and favor convention over configuration.
  * Accordingly, `Sexpr::Citrus::Parser` no longer takes options at construction either.
  * `Grammar#sexpr` does no longer allow parsing options as second argument, but takes tracking
    markers (see enhancements). To palliate to this, default parsing options can now be
    specified through `Grammar#default_parse_options` (see enhancements).

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