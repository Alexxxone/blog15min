FactoryGirl.define do

  factory :comment do
    association :post ,:factory => :post
    sequence(:body) { |n| "name#{n}" }
    created_at Time.now
    updated_at Time.now
  end
  factory :coment_admin, :parent => :comment do
    association :commentable, :factory => :admin_user
  end
  factory :coment_user, :parent => :comment do
    association :commentable, :factory => :user
  end



end



