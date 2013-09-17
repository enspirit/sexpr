require 'spec_helper'
module Sexpr::Grammar
  describe Tagging, "tag_sexpr" do
    include Tagging

    module TaggingReference
      module Node; end
      module Not; end
      module Lit; end
    end

    def default_tagging_module
      TaggingReference::Node
    end

    def tag(x)
      res = tag_sexpr(x)
      res.should eq(x)
      res
    end

    context 'when no tagging reference is provided' do

      it 'tags with the default tagging module if set' do
        tag([:lit]).should be_a(TaggingReference::Node)
        tag([:or]).should be_a(TaggingReference::Node)
      end

      it 'does not try to tag with a ruby class' do
        tag([:array]).should be_a(TaggingReference::Node)
      end

    end

    context 'when a tagging reference is provided' do

      def tagging_reference
        TaggingReference
      end

      it 'tags a sexpr at first level' do
        tag([:lit]).should be_a(TaggingReference::Lit)
      end

      it 'tags sexpr recursively' do
        res = tag([:not, [:lit, true]])
        res.should be_a(TaggingReference::Not)
        res.last.should be_a(TaggingReference::Lit)
      end

      it 'tags with the default tagging module when no match' do
        res = tag([:or]).should be_a(TaggingReference::Node)
      end

      it 'does not try to tag with a ruby class' do
        tag([:array]).should be_a(TaggingReference::Node)
      end
    end

  end
end