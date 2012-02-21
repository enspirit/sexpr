require 'spec_helper'
module Sexpr
  describe Grammar, "parse" do
    include Parser

    def parse(s)
      [:parsed, input_text(s)]
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

      it 'it accepts a string' do
        grammar.parse("Hello world").should eq([:parsed, "Hello world"])
      end

      it 'it accepts a path' do
        grammar.parse(Path.here).should eq([:parsed, File.read(__FILE__)])
      end

      it 'it accepts an IO' do
        File.open(__FILE__, 'r') do |io|
          grammar.parse(io).should eq([:parsed, File.read(__FILE__)])
        end
      end

    end # when a parser is set

  end
end