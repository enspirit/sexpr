require 'spec_helper'
module Sexpr::Grammar
  describe Tagging, "tagging_module_for" do
    include Tagging

    module TaggingReference
      module Node; end
      module Not; end
      module Lit; end
    end

    subject{ tagging_module_for(rulename) }

    context 'when there is a tagging reference and a default tagging module' do

      def tagging_reference
        TaggingReference
      end

      def default_tagging_module
        TaggingReference::Node
      end

      context 'when the module exists' do
        let(:rulename){ :not }

        it{ should be(TaggingReference::Not) }
      end

      context 'when the module does not exists' do
        let(:rulename){ :blah }

        it{ should be(TaggingReference::Node) }
      end
    end

    context 'when there is a no tagging reference but default tagging module' do

      def default_tagging_module
        TaggingReference::Node
      end

      let(:rulename){ :not }

      it{ should be(TaggingReference::Node) }
    end

    context 'when there is a a tagging reference and no default tagging module' do

      def tagging_reference
        TaggingReference
      end

      def default_tagging_module
        nil
      end

      context 'when the module exists' do
        let(:rulename){ :not }

        it{ should be(TaggingReference::Not) }
      end

      context 'when the module does not exists' do
        let(:rulename){ :blah }

        it{ should be_nil }
      end
    end

  end
end