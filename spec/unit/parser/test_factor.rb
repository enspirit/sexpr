require 'spec_helper'
module Sexpr
  describe Parser, "factor" do

    it 'silently returns when given a Parser' do
      p = Object.new.extend(Parser)
      Parser.factor(p).should eq(p)
    end

    it 'raises a UnrecognizedParserError when no class can be found' do
      lambda{
        Parser.factor(self)
      }.should raise_error(UnrecognizedParserError)
    end

  end
end