require 'spec_helper'
module Sexpr::Matcher
  describe NonTerminal, "match?" do

    let(:defn){ Sequence.new [Terminal.new(/^[a-z]+$/)]  }
    let(:rule){ NonTerminal.new :hello, defn             }

    subject{ rule.match?(sexpr) }

    context 'when match' do
      let(:sexpr){ [:hello, "world"] }

      it{ should be_true }
    end

    [
      [[:hello, "world"]],
      [:hello],
      [],
      [[]],
      [nil],
      nil
    ].each do |example|
      context "when no match, e.g. #{example.inspect}" do
        let(:sexpr){ example }

        it{ should be_false }
      end
    end

  end
end
