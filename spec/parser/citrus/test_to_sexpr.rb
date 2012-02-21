require 'spec_helper'
module Sexpr::Parser
  describe Citrus, "to_sexpr" do

    def parse(x, options = {})
      Struct.new(:value).new([:sexpr, x])
    end

    it 'calls value by default' do
      parser = Citrus.new(self)
      parser.to_sexpr("true").should eq([:sexpr, "true"])
    end

    it 'delegates to from_match_to_sexpr if specified' do
      parser = Citrus.new(self, :from_match_to_sexpr => lambda{|x| 12})
      parser.to_sexpr("true").should eq(12)
    end

  end
end