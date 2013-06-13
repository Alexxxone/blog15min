class PostTag < ActiveRecord::Base
  attr_accessible :post_id, :tag_id
  belongs_to :post
  belongs_to :tag
  #test
  validates_presence_of :post_id,:tag_id
end
