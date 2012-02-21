require 'spec_helper'
module Sexpr::Grammar
  describe Tagging, "tag_sexpr" do
    include Tagging

    module TaggingReference
      module Not; end
      module Lit; end
    end

    def tag(x)
      res = tag_sexpr(x, TaggingReference)
      res.should eq(x)
      res
    end

    it 'tags a sexpr at first level' do
      tag([:lit]).should be_a(TaggingReference::Lit)
    end

    it 'tags sexpr recursively' do
      res = tag([:not, [:lit, true]])
      res.should be_a(TaggingReference::Not)
      res.last.should be_a(TaggingReference::Lit)
    end

  end
end