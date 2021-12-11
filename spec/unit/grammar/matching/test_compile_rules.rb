require 'spec_helper'
module Sexpr
  module Grammar
    describe Matching, "compile_rules" do
      include Matching

      let(:yaml){
        <<-YAML
          bool_and:
            - [ bool_lit, bool_lit ]
          bool_lit:
            - true
            - false
          var_name:
            !ruby/regexp /^[a-z]+$/
        YAML
      }

      let(:rules){
        Sexpr.load_yaml(yaml)
      }

      subject{ compile_rules(rules) }

      it{ should be_a(Hash) }

      it 'has expected keys' do
        subject.keys.should eq([:bool_and, :bool_lit, :var_name])
      end

      it 'has expected values' do
        subject.values.each do |val|
          val.should be_a(Matcher::Rule)
        end
      end

      it 'has expected defn' do
        subject[:bool_and].defn.should be_a(Matcher::NonTerminal)
        subject[:bool_lit].defn.should be_a(Matcher::Alternative)
        subject[:var_name].defn.should be_a(Matcher::Terminal)
      end

    end
  end
end
