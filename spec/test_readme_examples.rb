require 'spec_helper'
describe "the README examples" do

  it 'works as announced' do

    grammar = SexpGrammar.load(<<-YAML)

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

    f = (grammar === [:bool_and, [:bool_not, [:var_ref, "x"]], [:literal, true]])
    f.should be_true

    f = (grammar === [:bool_and, [:literal, "true"]])
    f.should be_false
  end

end