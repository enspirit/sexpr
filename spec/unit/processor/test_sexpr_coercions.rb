require 'spec_helper'
module Sexpr
  class Processor
    describe SexprCoercions do

      let(:helper){
        SexprCoercions.new
      }
      let(:processor){
        Rewriter.new
      }

      it 'extends input sexprs' do
        sexpr = [:hello, "world"]
        seen = helper.call(processor, sexpr) do |_,n|
          n.should be_a(Sexpr)
          n
        end
        seen.should eq(sexpr)
      end

      it 'extends output sexprs' do
        sexpr = [:hello, "world"]
        seen = helper.call(processor, sexpr) do |_,n|
          n.should be_a(Sexpr)
          [:result]
        end
        seen.should eq([:result])
        seen.should be_a(Sexpr)
      end

      it 'does not require the output to be a sexpr' do
        sexpr = [:hello, "world"]
        seen = helper.call(processor, sexpr) do |_,n|
          n.should be_a(Sexpr)
          "blah"
        end
        seen.should eq("blah")
        seen.should_not be_a(Sexpr)
      end

      it 'fails with a string, unless the underlying grammar may parse' do
        lambda{
          helper.call(processor, "blah") do |_,n| end
        }.should raise_error(NoParserError)
      end

    end
  end
end