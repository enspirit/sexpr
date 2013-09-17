require 'spec_helper'
describe BoolExpr, 'the validation feature' do
  subject{ BoolExpr }

  it 'validates s-expressions' do
    subject.match?([:bool_lit, true]).should be_true
    subject.match?([:bool_lit, "x"]).should be_false
  end

  it 'validates s-expressions against specific rules' do
    subject[:bool_lit].match?([:bool_lit, true]).should be_true
    subject[:bool_and].match?([:bool_lit, true]).should be_false
  end

end