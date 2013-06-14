FactoryGirl.define do

    factory :tag do
      sequence(:name) { |n| "name#{n}" }
      created_at Time.now
      updated_at Time.now
    end

end



