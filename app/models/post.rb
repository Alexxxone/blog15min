class Post < ActiveRecord::Base
  attr_accessible :body, :data, :title ,:confirmed  ,:tags_attributes ,:tag_ids
  has_many :comments , dependent: :destroy

  #test
  validate :body, :title,:user_id, :presence => true

  belongs_to :user

  has_many :post_tags
  has_many :tags,:through => :post_tags

  accepts_nested_attributes_for :tags

  before_save :save_post
  before_update :save_post

  attr_accessor :tags_attributes





  scope :not_hidden, where("title NOT LIKE ? ", "%hidden%")
  scope :user_confirmed, where("confirmed =1")
  scope :waiting_to_approve, where("confirmed =0")
  scope :waiting_warning, where("confirmed =2")





  def save_post
    if tags_attributes.is_a? (Hash)
      self.tags = tags_attributes.map do |_, tag|
        Tag.find_or_create_by_name(tag[:name])
      end
    end
  end



end

