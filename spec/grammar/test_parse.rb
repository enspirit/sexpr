require 'spec_helper'
module Sexpr
  describe Grammar, "parse" do
    include Parser

    def parse(s, options = {})
      [options[:root] || :parsed, input_text(s)]
    end

    context 'when no parser is set' do

      def grammar(options = {})
        Sexpr.load({}, {})
      end

      it 'raises an error' do
        lambda{
          grammar.parse("Hello world")
        }.should raise_error(NoParserError)
      end

    end

    context 'when a parser is set' do

      def grammar(options = {})
        Sexpr.load({}, {:parser => self})
      end

      it 'delegates the call to the parser' do
        grammar.parse("Hello world").should eq([:parsed, "Hello world"])
      end

      it 'passes options' do
        grammar.parse("world", :root => :hello).should eq([:hello, "world"])
      end

    end # when a parser is set

  end
end