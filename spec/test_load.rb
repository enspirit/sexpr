require 'spec_helper'
module SexpGrammar
  describe SexpGrammar, "load" do

      let(:grammar){ SexpGrammar.load(arg) }

      context "on grammar.yml" do
        let(:arg){ Path.dir/"grammar.yml" }

        it 'returns a Grammar' do
          grammar.should be_a(Grammar)
        end

      end # grammar.yml

      context 'with a Hash' do
        let(:arg){ {:hello => /[a-z]+/} }

        it 'returns a Grammar' do
          grammar.should be_a(Grammar)
        end

      end

      context 'with a String' do
        let(:arg){ "hello: true" }

        it 'returns a Grammar' do
          grammar.should be_a(Grammar)
        end

      end

  end
end