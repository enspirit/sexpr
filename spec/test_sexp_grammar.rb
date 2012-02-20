require File.expand_path('../spec_helper', __FILE__)
describe SexpGrammar do

  it "should have a version number" do
    SexpGrammar.const_defined?(:VERSION).should be_true
  end

end
