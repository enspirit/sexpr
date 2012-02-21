require 'spec_helper'
module Sexpr
  describe Terminal, "match?" do

    let(:rule){ Terminal.new(arg) }

    describe "with true" do
      let(:arg){ true }

      it 'returns true on match' do
        rule.should be_match(true)
        (rule === true).should be_true
      end

      it 'returns false on no match' do
        rule.should_not be_match([])
        rule.should_not be_match(nil)
        rule.should_not be_match(false)
      end

    end

    describe "with false" do
      let(:arg){ false }

      it 'returns true on match' do
        rule.should be_match(false)
        (rule === false).should be_true
      end

      it 'returns false on no match' do
        rule.should_not be_match([])
        rule.should_not be_match(nil)
        rule.should_not be_match(true)
      end

    end

    describe "with nil" do
      let(:arg){ nil }

      it 'returns true on match' do
        rule.should be_match(nil)
        (rule === nil).should be_true
      end

      it 'returns false on no match' do
        rule.should_not be_match([])
        rule.should_not be_match(false)
        rule.should_not be_match(true)
      end

    end

  end
end