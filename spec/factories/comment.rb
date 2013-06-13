FactoryGirl.define do

  factory :comment do
    association :post ,:factory => :post
    association :commentable, :factory => :user
  end
  factory :coment_admin, :parent => :comment do
    association :commentable, :factory => :admin_user
  end

end



