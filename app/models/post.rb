class Post < ActiveRecord::Base
  attr_accessible :body, :data, :title ,:confirmed  ,:tags_attributes ,:tag_ids
  has_many :comments
  belongs_to :user
  has_many :post_tags
  has_many :tags,:through => :post_tags
  accepts_nested_attributes_for :tags

  hidden = "hidden"
  scope :not_hidden, where("title NOT LIKE ? ", "%#{hidden}%")
  scope :user_confirmed, where("confirmed !=0")
  scope :waitingToApprove,where("confirmed =0")
end

