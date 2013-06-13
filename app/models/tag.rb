class Tag < ActiveRecord::Base
  attr_accessible :name
  has_many :post_tags
  has_many :posts,:through => :post_tags
  accepts_nested_attributes_for :posts

  #test
  validates_presence_of :name
end
