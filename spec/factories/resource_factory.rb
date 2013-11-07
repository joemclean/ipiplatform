FactoryGirl.define do
  factory :resource do
    name 'resource_name'
    link 'resource_link'
    description 'resource_description'
    full_description 'resource_full_description'
    user_id 1
    source 'resource_source'
    tag_list 'resource_tag_list'
  end
end