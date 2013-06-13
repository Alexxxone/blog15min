class Comment < ActiveRecord::Base
  attr_accessible :body, :commentable_type, :commentable_id
  belongs_to :commentable, :polymorphic => true
  belongs_to :post
  #test
  validates_presence_of :body,:commentable_type,:commentable_id



end
