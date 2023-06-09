require 'spec_helper'
module Sexpr
  describe Parser, "input_text" do
    include Parser

    it 'recognizes a string' do
      input_text("Hello world").should eq("Hello world")
    end

    it 'accepts a path' do
      input_text(Path.file).should eq(File.read(__FILE__))
    end

    it 'accepts an IO' do
      File.open(__FILE__, 'r') do |io|
        input_text(io).should eq(File.read(__FILE__))
      end
    end

    it 'raises a InvalidParseSourceError when invalid source' do
      lambda{
        input_text(self)
      }.should raise_error(InvalidParseSourceError)
    end

  end
end
