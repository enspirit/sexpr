require 'spec_helper'
module Sexpr::Matcher
  describe Terminal, "terminal_match?" do

    before do
      class Terminal; public :terminal_match?; end
    end

    let(:terminal){ Terminal.new(arg) }

    context "with a Regexp" do
      let(:arg){ /^[a-z]+$/ }

      it 'matches a matching string' do
        terminal.terminal_match?("hello").should be_truthy
      end

      it 'matches a non matching string' do
        terminal.terminal_match?("12").should be_falsey
      end

      it 'does not match a sexp' do
        terminal.terminal_match?([:sexp, "Hello World"]).should be_falsey
      end

      it 'does not match nil' do
        terminal.terminal_match?(nil).should be_falsey
      end
    end

    context "with true" do
      let(:arg){ true }

      it 'matches true' do
        terminal.terminal_match?(true).should be_truthy
      end

      it 'does not match false/nil' do
        terminal.terminal_match?(false).should be_falsey
        terminal.terminal_match?(nil).should be_falsey
      end

      it 'does not match anything else' do
        terminal.terminal_match?([]).should be_falsey
        terminal.terminal_match?([:sexp]).should be_falsey
        terminal.terminal_match?("true").should be_falsey
      end
    end

    context "with false" do
      let(:arg){ false }

      it 'matches false' do
        terminal.terminal_match?(false).should be_truthy
      end

      it 'does not match true/nil' do
        terminal.terminal_match?(true).should be_falsey
        terminal.terminal_match?(nil).should be_falsey
      end

      it 'does not match anything else' do
        terminal.terminal_match?([]).should be_falsey
        terminal.terminal_match?([:sexp]).should be_falsey
        terminal.terminal_match?("false").should be_falsey
      end
    end

    context "with nil" do
      let(:arg){ nil }

      it 'matches nil' do
        terminal.terminal_match?(nil).should be_truthy
      end

      it 'does not match true/false' do
        terminal.terminal_match?(true).should be_falsey
        terminal.terminal_match?(false).should be_falsey
      end

      it 'does not match anything else' do
        terminal.terminal_match?([]).should be_falsey
        terminal.terminal_match?([:sexp]).should be_falsey
        terminal.terminal_match?("nil").should be_falsey
      end
    end

    context "with a Class" do
      let(:arg){ Symbol }

      it 'matches a symbol' do
        terminal.terminal_match?(:hello).should be_truthy
      end

      it 'does not match a string' do
        terminal.terminal_match?("hello").should be_falsey
      end

      it 'does not match anything else' do
        terminal.terminal_match?(nil).should be_falsey
        terminal.terminal_match?([]).should be_falsey
        terminal.terminal_match?([:sexp]).should be_falsey
        terminal.terminal_match?("nil").should be_falsey
      end
    end

  end
end