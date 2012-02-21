require 'spec_helper'
module Sexpr
  describe Grammar, "install_path" do

    def grammar(input = {})
      Sexpr.load(input)
    end

    it 'is nil by default' do
      grammar.path.should be_nil
    end

    it 'keeps the specified value if any' do
      grammar(:path => "blah").path.should eq("blah")
    end

  end
end