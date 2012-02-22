require 'spec_helper'
module Sexpr
  describe Grammar, "parse" do

    def grammar
      Sexpr.load(:parser => parser).extend Module.new{
        def default_parse_options
          {:root => :root_rule, :hello => "world"}
        end
      }
    end

    context 'when no parser is set' do
      let(:parser){ nil }

      it 'raises an error' do
        lambda{
          grammar.parse("Hello world")
        }.should raise_error(NoParserError)
      end

    end

    context 'when a parser is set' do
      let(:parser){
        Object.new.extend Module.new{
          include Parser
          def parse(s, options = {})
            [options[:root], "#{s} #{options[:hello]}"]
          end
        }
      }

      it 'uses default options when no options are passed' do
        grammar.parse("Hello").should eq([:root_rule, "Hello world"])
      end

      it 'merge passed options with default ones' do
        grammar.parse("Hello", :root => :another_rule).should eq([:another_rule, "Hello world"])
      end

    end # when a parser is set

  end
end