require 'spec_helper'
module Sexpr
  describe Grammar, "to_sexpr" do
    include Parser

    def sexpr(expr, opts = {})
      @sexpr = Sexpr.load(:parser => parser).to_sexpr(expr, opts)
    end

    after{
      @sexpr.should be_a(Sexpr) if @sexpr
    }

    context 'when no parser is set' do
      let(:parser){ nil }

      it 'silently returns a sexpr array' do
        sexpr([:sexpr, "world"]).should eq([:sexpr, "world"])
      end

      it 'raises an error when parser is needed' do
        lambda{
          sexpr("Hello world")
        }.should raise_error(NoParserError)
      end

    end

    context 'when a parser is set' do
      let(:parser){ self }

      def to_sexpr(s, options = {})
        [options[:root] || :parsed, s]
      end

      it 'silently returns a sexpr array' do
        sexpr([:sexpr, "world"]).should eq([:sexpr, "world"])
      end

      it 'delegates the call to the parser' do
        sexpr("Hello world").should eq([:parsed, "Hello world"])
      end

      it 'passes options' do
        sexpr("world", :root => :hello).should eq([:hello, "world"])
      end

    end # when a parser is set

  end
end