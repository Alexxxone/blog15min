class Post < ActiveRecord::Base
  attr_accessible :body, :data, :title
  has_many :comments
  belongs_to :user
  hidden = "hidden"
  scope :not_hidden, where("title NOT LIKE ? ", "%#{hidden}%")
end

