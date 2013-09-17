require 'spec_helper'
module Sexpr
  describe Grammar::Options, "install_root" do
    include Grammar::Options

    let(:rules){ {:t => /[a-z]+/, :nt => true} }

    it 'is the first key by default' do
      install_options :rules => rules do
        root.should eq(:t)
      end
    end

    it 'is the specified rule when specified' do
      install_options :rules => rules, :root => :nt do
        root.should eq(:nt)
      end
    end

    it 'is converted to a Symbol is a String' do
      install_options :root => "nt" do
        root.should eq(:nt)
      end
    end

  end
end