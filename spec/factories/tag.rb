FactoryGirl.define do

  factory :tag do
    association :post ,:factory => :post
    sequence(:name) { |n| "name#{n}@mail.ru" }
  end

end

