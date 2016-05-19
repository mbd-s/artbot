FactoryGirl.define do
  factory :admin do
    sequence(:username) { |n| "admin#{n}" }
    sequence(:email) { |n| "g#{n}@g.com" }
    password "testtest"
    confirmed_at { Time.now }
  end
end
