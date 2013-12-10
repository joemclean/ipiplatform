FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email#{n}@factory.com"}
    password '0000'
    password_confirmation '0000'
    name 'factory girl'
    is_admin false

    trait :admin do
      is_admin true
    end
  end
end