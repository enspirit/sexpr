require 'spec_helper'
module Sexpr
  describe Grammar, "new" do

    subject{ Grammar.new }

    it 'factors a subclass of Grammar' do
      pending{
        subject.should be_a(Class)
        subject.super_class.should eq(Grammar)
      }
    end

  end
end