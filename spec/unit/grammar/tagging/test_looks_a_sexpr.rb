require 'spec_helper'
module Sexpr::Grammar
  describe Tagging, "looks_a_sexpr" do
    include Tagging

    it 'recognizes s-expressions' do
      looks_a_sexpr?([:lit]).should be_true
    end

    it 'does not recognize empty arrays' do
      looks_a_sexpr?([]).should be_false
    end

    it 'does not recognize others' do
      looks_a_sexpr?(nil).should be_false
      looks_a_sexpr?(:lit).should be_false
    end

  end
end