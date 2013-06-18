# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  post_id          :integer
#  body             :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_id   :integer
#  commentable_type :string(255)
#

class Comment < ActiveRecord::Base
  attr_accessible :body, :commentable_type, :commentable_id
  belongs_to :commentable, :polymorphic => true
  belongs_to :post
  #test
  validates_presence_of :body,:commentable_type,:commentable_id



end
