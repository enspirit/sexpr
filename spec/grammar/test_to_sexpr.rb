require 'spec_helper'
module Sexpr
  describe Grammar, "to_sexpr" do
    include Parser

    def grammar
      Sexpr.load(:parser => parser)
    end

    def to_sexpr(s, options = {})
      [options[:root] || :parsed, s]
    end

    context 'when no parser is set' do
      let(:parser){ nil }

      it 'silently returns a sexpr array' do
        grammar.to_sexpr([:sexpr, "world"]).should eq([:sexpr, "world"])
      end

      it 'raises an error' do
        lambda{
          grammar.to_sexpr("Hello world")
        }.should raise_error(NoParserError)
      end

    end

    context 'when a parser is set' do
      let(:parser){ self }

      it 'silently returns a sexpr array' do
        grammar.to_sexpr([:sexpr, "world"]).should eq([:sexpr, "world"])
      end

      it 'delegates the call to the parser' do
        grammar.to_sexpr("Hello world").should eq([:parsed, "Hello world"])
      end

      it 'passes options' do
        grammar.to_sexpr("world", :root => :hello).should eq([:hello, "world"])
      end

    end # when a parser is set

  end
end