FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "name#{n}@mail.ru" }
    password "123456"

  end

end

