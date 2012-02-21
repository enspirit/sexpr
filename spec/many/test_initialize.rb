require 'spec_helper'
module Sexpr
  describe Many, "initialize" do

    it 'understands a single min' do
      many = Many.new(nil, 2)
      many.min.should eq(2)
      many.max.should be_nil
    end

    it 'understands a min and a max' do
      many = Many.new(nil, 2, 10)
      many.min.should eq(2)
      many.max.should eq(10)
    end

    it 'understands ?' do
      many = Many.new(nil, '?')
      many.min.should eq(0)
      many.max.should eq(1)
    end

    it 'understands *' do
      many = Many.new(nil, '*')
      many.min.should eq(0)
      many.max.should be_nil
    end

    it 'understands +' do
      many = Many.new(nil, '+')
      many.min.should eq(1)
      many.max.should be_nil
    end

  end
end