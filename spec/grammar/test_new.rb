require 'spec_helper'
module Sexpr
  describe Grammar, "new" do

    subject{ Grammar.new }

    it 'factors a module' do
      subject.should be_a(Module)
      subject.should be_a(Grammar::Options)
      subject.should be_a(Grammar::Matching)
      subject.should be_a(Grammar::Parsing)
    end

  end
end