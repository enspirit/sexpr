require 'spec_helper'
module Sexpr
  describe Node, "sexpr_copy" do

    let(:markers){
      {:hello => 'world'}
    }
    let(:array){
      [:bool_not, [:bool_lit, true]]
    }
    let(:the_sexpr){
      sexpr(array, markers)
    }

    it 'degenerates to a tag preserving dup without a block' do
      [the_sexpr.sexpr_copy, the_sexpr.dup].each do |copy|
        copy.object_id.should_not eq(the_sexpr.object_id)
        copy.should eq(array)
        copy.should be_a(Sexpr)
        copy.tracking_markers.should eq(markers)
      end
    end

    it 'works ala inject with a block' do
      copy = the_sexpr.sexpr_copy do |base, child|
        base << [:bool_lit, false]
      end
      copy.object_id.should_not eq(the_sexpr.object_id)
      copy.should eq([:bool_not, [:bool_lit, false]])
      copy.should be_a(Sexpr)
      copy.tracking_markers.should eq(markers)
    end

  end
end