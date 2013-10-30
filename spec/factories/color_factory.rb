FactoryGirl.define do
  factory :color do
    name 'color_name'
    description 'color description'
    image 'color image name'

    association :value_proposition, strategy: :build

  end
end