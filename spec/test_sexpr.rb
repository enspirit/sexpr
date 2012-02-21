require File.expand_path('../spec_helper', __FILE__)
describe Sexpr do

  it "should have a version number" do
    Sexpr.const_defined?(:VERSION).should be_true
  end

end