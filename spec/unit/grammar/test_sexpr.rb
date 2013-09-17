require 'spec_helper'
module Sexpr
  describe Grammar, "sexpr" do

    def sexpr(expr, markers = nil)
      @sexpr = Sexpr.load(:parser => parser).sexpr(expr, markers)
    end

    after{
      @sexpr.should be_a(Sexpr) if @sexpr
    }

    context 'on an array' do
      let(:parser){ nil }

      it 'returns the sexpr array' do
        sexpr([:sexpr, "world"]).should eq([:sexpr, "world"])
      end

      it 'extends it with the Sexpr module' do
        sexpr([:sexpr, "world"]).should be_a(Sexpr)
      end

      it 'sets the markers if any' do
        markers = {:hello => "world"}
        sexpr([:sexpr, "world"], markers).tracking_markers.should eq(markers)
      end

    end # on an array

    context 'on a Sexpr' do
      let(:parser){ nil }

      it 'merges the markers if provided' do
        sexpr = sexpr([:sexpr, "world"], :hello => true, :who => "world")
        sexpr.tracking_markers.should eq(:hello => true, :who => "world")
        sexpr = sexpr(sexpr, :who => "WORLD")
        sexpr.tracking_markers.should eq(:hello => true, :who => "WORLD")
      end

    end

    context 'when no parser is set and a String' do
      let(:parser){ nil }

      it 'raises an error when parser is needed' do
        lambda{
          sexpr("Hello world")
        }.should raise_error(NoParserError)
      end

    end

    context 'when a parser is set and a String' do
      let(:parser){
        Object.new.extend Module.new{
          include Parser
          def parse(s, options)
            s.upcase
          end
          def to_sexpr(s)
            Sexpr.sexpr([:parsed, s], {:hello => "world"})
          end
        }
      }

      it 'delegates the call to the parser' do
        sexpr("Hello world").should eq([:parsed, "HELLO WORLD"])
      end

      it 'extends it with the Sexpr module' do
        sexpr("Hello world").should be_a(Sexpr)
      end

      it 'sets the markers through recursive application' do
        sexpr("Hello world").tracking_markers.should eq({:hello => "world"})
      end

      it 'merge the provided markers' do
        expected = {:hello => "world", :who => "world"}
        sexpr("Hello world", {:who => "world"}).tracking_markers.should eq(expected)
      end

    end # when a parser is set

  end
end