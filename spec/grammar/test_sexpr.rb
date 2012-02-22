require 'spec_helper'
module Sexpr
  describe Grammar, "sexpr" do

    def sexpr(expr, opts = {})
      @sexpr = Sexpr.load(:parser => parser).sexpr(expr, opts)
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
      let(:parser){
        Object.new.extend Module.new{
          include Parser
          def parse(s, options)
            s
          end
          def to_sexpr(s)
            [:parsed, s]
          end
        }
      }

      it 'silently returns a sexpr array' do
        sexpr([:sexpr, "world"]).should eq([:sexpr, "world"])
      end

      it 'delegates the call to the parser' do
        sexpr("Hello world").should eq([:parsed, "Hello world"])
      end

    end # when a parser is set

  end
end