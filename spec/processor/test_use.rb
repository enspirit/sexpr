require 'spec_helper'
module Sexpr
  describe Processor, "use" do

    it 'installs the preprocessors properly' do
      Processor.preprocessors.should eq([])
      Preprocessed.preprocessors.should eq([ Preprocessed::Prefix ])
      SubPreprocessed.preprocessors.should eq([ Preprocessed::Prefix, {:upcased => SubPreprocessed::Upcase} ])
    end

    it 'sets attribute readers for hashed' do
      Preprocessed.new.should_not respond_to(:upcased)
      SubPreprocessed.new.should respond_to(:upcased)
    end

  end
end