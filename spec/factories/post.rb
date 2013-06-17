FactoryGirl.define do

  factory :post do
    association :user ,:factory => :user
    title 'big title'
    body 'some big body text'
    confirmed 0
  end

  factory :post_confirmed, :parent => :post do
    confirmed 1
  end

  factory :post_warning, :parent => :post do
    confirmed 2
  end


end

