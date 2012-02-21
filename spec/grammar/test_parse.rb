require 'spec_helper'
module Sexpr
  describe Grammar, "parse" do

    def parser
      Object.new.tap{|x|
        def x.parse(s)
          Struct.new(:value).new([:parsed, s])
        end
      }
    end

    def grammar(options = {})
      Sexpr.load({}, {:parser => parser})
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

  end
end