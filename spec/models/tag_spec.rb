require 'spec_helper'
describe Tag do




  it { should have_many(:post_tags) }
  it { should have_many(:post_tags).through(:post_tags) }
  it { should allow_mass_assignment_of(:name) }
  it { should accept_nested_attributes_for (:post) }



  it "should create tag" do
    tag = create(:tag)
    tag.name
  end








end



=begin



class Tag < ActiveRecord::Base
  attr_accessible :name
  has_many :post_tags
  has_many :posts,:through => :post_tags
  accepts_nested_attributes_for :posts
end



=end