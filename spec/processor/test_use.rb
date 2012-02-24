require 'spec_helper'
module Sexpr
  describe Processor, "use" do

    it 'installs the preprocessors properly' do
      expected = []
      Processor.preprocessors.should eq(expected)

      expected << [Preprocessed::Prefix, {:prefix => "prefix_"}]
      Preprocessed.preprocessors.should eq(expected)

      expected << [ {:upcased => SubPreprocessed::Upcase}, nil ]
      SubPreprocessed.preprocessors.should eq(expected)
    end

    it 'sets attribute readers for hashes' do
      Preprocessed.new.should_not respond_to(:upcased)
      SubPreprocessed.new.should respond_to(:upcased)
    end

  end
end