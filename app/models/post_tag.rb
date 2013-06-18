# == Schema Information
#
# Table name: post_tags
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  tag_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostTag < ActiveRecord::Base
  attr_accessible :post_id, :tag_id
  belongs_to :post
  belongs_to :tag

  #test
  validates_presence_of :post_id,:tag_id

  before_destroy :check_tag

  def check_tag
    current_tag = self.tag
    if tag.posts.count <= 1
      Tag.destroy(current_tag.id)
    end
  end
end
