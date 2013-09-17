require 'spec_helper'
module Sexpr::Matcher
  describe Rule, "eat" do

    let(:rule){ Rule.new :hello, self }

    def eat(seen)
      @seen = seen
    end

    it 'delegates to the defn' do
      rule.eat([:foo])
      @seen.should eq([:foo])
    end

  end
end
