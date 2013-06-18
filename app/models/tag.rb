# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ActiveRecord::Base
  attr_accessible :name
  has_many :post_tags
  has_many :posts,:through => :post_tags
  accepts_nested_attributes_for :posts

  validates_uniqueness_of :name
  #test
  validates_presence_of :name
end
