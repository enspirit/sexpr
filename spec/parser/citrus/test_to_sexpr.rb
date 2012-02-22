require 'spec_helper'
module Sexpr::Parser
  describe Citrus, "to_sexpr" do

    let(:parser){
      Citrus.new(bool_expr_parser)
    }

    subject{ parser.to_sexpr(parser.parse("not x")) }

    it 'calls sexpr' do
      subject.should eq([:bool_not, [:var_ref, "x"]])
    end

    it 'returns a Sexpr object' do
      subject.should be_a(Sexpr)
    end

    it 'tags the modules recursively' do
      subject.last.should be_a(Sexpr)
    end

    it 'sets the markers' do
      [subject, subject.last].each do |s|
        s.tracking_markers.should be_a(Hash)
        s.tracking_markers[:citrus_match].should_not be_nil
      end
    end

  end
end