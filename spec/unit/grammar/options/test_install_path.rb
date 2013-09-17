require 'spec_helper'
module Sexpr
  describe Grammar::Options, "install_path" do
    include Grammar::Options

    it 'is nil by default' do
      install_options({}) do
        path.should be_nil
      end
    end

    it 'keeps the specified value if any' do
      install_options :path => "blah" do
        path.should eq("blah")
      end
    end

  end
end