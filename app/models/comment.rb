class Comment < ActiveRecord::Base
  attr_accessible :body, :commentable_type, :commentable_id
  belongs_to :commentable, :polymorphic => true
end
