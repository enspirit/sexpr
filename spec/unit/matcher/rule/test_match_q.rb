require 'spec_helper'
module Sexpr::Matcher
  describe Rule, "match?" do

    let(:rule){ Rule.new :hello, self }

    def match?(seen)
      @seen = seen
    end

    it 'delegates to the defn' do
      rule.match?([:foo])
      @seen.should eq([:foo])
    end

  end
end
