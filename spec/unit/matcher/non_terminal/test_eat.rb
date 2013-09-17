require 'spec_helper'
module Sexpr::Matcher
  describe NonTerminal, "eat" do

    let(:defn){ Sequence.new [Terminal.new(/^[a-z]+$/)]  }
    let(:rule){ NonTerminal.new :hello, defn             }

    subject{ rule.eat(sexpr) }

    context 'when match' do
      let(:sexpr){ [[:hello, "world"], "!"] }

      it{ should eq(["!"]) }
    end

    [
      [:hello, "world"],
      [:hello],
      [],
      [[]],
      [nil],
    ].each do |example|
      context "when no match, e.g. #{example.inspect}" do
        let(:sexpr){ example }

        it{ should be_nil }
      end
    end

  end
end
