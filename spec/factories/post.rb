FactoryGirl.define do

  factory :post do
    association :user ,:factory => :user
    title 'big title'
    body 'some big body text'
    confirmed 0
  end


end

