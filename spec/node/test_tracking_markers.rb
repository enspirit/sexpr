require 'spec_helper'
module Sexpr
  describe Node, "tracking_markers" do

    it 'defaults to {}' do
      sexpr([:lit, true]).tracking_markers.should eq({})
    end

    it 'can be installed through a private writer' do
      sexpr, markers = sexpr([:lit, true]), {:hello => "world"}
      sexpr.tracking_markers = markers
      sexpr.tracking_markers.should eq(markers)
    end

    it 'are installed through the second argument of sexpr' do
      markers = {:hello => "World"}
      sexpr([:lit, true], markers).tracking_markers.should eq(markers)
    end

  end
end