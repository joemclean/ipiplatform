FactoryGirl.define do
  factory :color do
    name 'color_name'
    description 'color_description'
    image 'placeholder.gif'

    association :value_proposition, strategy: :build
  end
end