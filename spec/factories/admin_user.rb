FactoryGirl.define  do

  factory :admin_user do
    sequence(:email) { |n| "name#{n}@mail.ru" }
    password "123456"
  end

end

