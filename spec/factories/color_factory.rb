FactoryGirl.define do
  factory :color do
    name 'color_name'
    description 'color_description'
    image 'color_image_name'

    association :value_proposition, strategy: :build
  end
end