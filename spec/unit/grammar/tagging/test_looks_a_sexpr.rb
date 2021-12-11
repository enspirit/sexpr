require 'spec_helper'
module Sexpr::Grammar
  describe Tagging, "looks_a_sexpr" do
    include Tagging

    it 'recognizes s-expressions' do
      looks_a_sexpr?([:lit]).should be_truthy
    end

    it 'does not recognize empty arrays' do
      looks_a_sexpr?([]).should be_falsey
    end

    it 'does not recognize others' do
      looks_a_sexpr?(nil).should be_falsey
      looks_a_sexpr?(:lit).should be_falsey
    end

  end
end