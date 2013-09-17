require 'spec_helper'
describe Sexpr do

  it "should have a version number" do
    Sexpr.const_defined?(:VERSION).should be_true
  end

end