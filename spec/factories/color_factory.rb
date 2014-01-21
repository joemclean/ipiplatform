def file_upload_with file_name
  test_document = "#{Rails.root}/spec/files/#{file_name}.jpg"
  Rack::Test::UploadedFile.new(test_document, "image/jpeg")
end

FactoryGirl.define do
  factory :color do
    name 'color_name'
    description 'color_description'

    association :value_proposition_category, strategy: :build
  end
end