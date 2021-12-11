# 1.0.0 / 2021-12-11

* Upgrade project structure to modern Enspirit practices

* Citrus dependency upgraded to 3.x and code fixed accordingly

# 0.6.0 / 2012-09-13

* Major enhancements (possibly breaking changes)

  * All grammar rules are now proper Matcher::Rule instances. A NonTerminal
    matcher is added and is used for non-terminal rule productions and matching
    (all but Terminal and Alternative).
  * `Rewriter.sexpr_grammar` and `Rewriter#sexpr_grammar` have been removed.
    `Processor.grammar` and `Processor#grammar` are provided instead.

* Minor enhancements

  * Added `Grammar#tagging_module_for(rulename)` that returns the user-defined
    module used to tag a given grammar rule production.
  * `Grammar#looks_a_sexpr?(arg)` became public.

# 0.5.1 / 2012-03-13

* Minor enhancements

  * Modules and Classes are now recognized for terminals in the same way as Regexp, true,
    false and nil. As there are quite a few bugs in Psych/Sick to put class names in .yaml
    files, Sexpr recognizes them also as strings starting with '::' (e.g. ::Symbol).

* Bug fixes

  * Use `reference.const_get(name, *false*)` when looking for tagging modules to avoid
    finding ruby classes such as Array when tagging sexpr such as [:array, ...].

# 0.5.0 / 2012-02-25

* Major enhancements

  * `Processor#apply` is introduced and is intended to be used to apply processing rules
    from the inside of the processor class. This method is equivalent to `#call` when no
    preprocessor is installed (see below).
  * Preprocessors can now be installed on a Processor through its `use` class method.
    Preprocessors are applied ala 'Enumerable#inject' on the s-expression passed at
    `Prcoessor#call`. The preprocessed result is then passed to `#apply` for further
    processing by the processor itself.
    (Please note that preprocessing is *not* performed by `#apply` itself; preprocessing
    is typically applied once one the whole abstract syntax tree instead of successively
    when its nodes are encountered. Tip: use helpers for such behavior).
  * `Processor.use` can also be used to make specific computations ahead of processing
    (such as a symbol table). For this, simply pass a Hash that maps a computation name
    to a processor class. Attribute readers are automatically installed on the processor
    class and instance variables set by `#call` accordingly.
    (Please note such preprocessors do not participate to the rewriting chain described
    above.)

* Minor enhancements

  * `Processor.call(sexpr, opts)` is a shortcut for `Processor.new(opts).call(sexpr)`
  * `Grammar#default_taggging_module` is introduced for cases where either no fine-grained
    tagging is needed (e.g. all nodes tagged with the same Node module) or fine-grained
    tagging is needed but is not a total function (e.g. not all nodes have a
    specialization of Node).

* Bug fixes

  * Processor options taken at construction are now correctly kept under @options (an
    attribute reader is provided)

* Breaking changes

  * The `Processor#main_processor` feature (undocumented and unused in examples) has been
    removed. Using preprocessors is much cleaner that linking processors to each other.

# 0.4.0 / 2012-02-23

* Major enhancements

  * A processing/rewriting framework has been added to Sexpr. See the `Processor` and
    `Rewriter` classes, as well as the boolean expression example.
  * Tracking markers can now decorate s-expressions, provided they include the `Sexpr`
    module. Tracking markers are a simple Hash of meta-information (i.e. not taken into
    account for equality for s-expressions). Such markers can be set with
    `Grammar#sexpr(sexpr, markers)`. Default markers are typically provided by parsers for
    traceability of the s-expression with the source text it comes from.

* Minor enhancements

  * `Citrus::Parser#parse` is now idempotent and so is `Grammar#parse` therefore.
  * The module to use for finding tag modules through `const_get` can now be overridden in
    `Grammar#tagging_reference`.
  * Default parsing options can now be specified in `Grammar#default_parse_options`. These
    options are used by `Grammar#sexpr` when parsing is needed.

* Breaking changes

  * `Parser.factor` does no longer accept options. This is to avoid the 'yet another
    options' symptom and favor convention over configuration.
  * Accordingly, `Sexpr::Citrus::Parser` no longer takes options at construction either.
  * `Grammar#sexpr` does no longer allow parsing options as second argument, but takes
    tracking markers (see enhancements). To palliate to this, default parsing options can
    now be specified through `Grammar#default_parse_options` (see enhancements).

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
    s-expression. The latter, and all its sub-expressions are automatically tagged with
    the Sexpr module, as well as with user-defined modules. The latter are automatically
    discovered with a convention over configuration heuristics that associates rule names
    to module names. That convention may however be overridden with specific grammar
    methods (see the BoolExpr example).

# 0.2.0 / 2012-02-21

* Enhancements

  * The project has been renamed as Sexpr instead of SexpGrammar
  * The root rule to use can now be specified in the options hash taken as second argument
    of `SexpGrammar.grammar(..., :root => :some_rule_name)`

# 0.1.0 / 2012-02-20

* Enhancements

  * Birthday!