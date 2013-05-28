class Post < ActiveRecord::Base
  attr_accessible :body, :data, :title
  has_many :comments
  hidden = "hidden"
  scope :not_hidden, where("title NOT LIKE ? ", "%#{hidden}%")
end

