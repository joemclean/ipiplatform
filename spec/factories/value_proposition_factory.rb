def file_upload_with file_name
  test_document = "#{Rails.root}/spec/files/#{file_name}.jpg"
  Rack::Test::UploadedFile.new(test_document, "image/jpeg")
end

FactoryGirl.define do
  factory :value_proposition do
    name 'value_proposition_name'
    description 'value_proposition_description'

    association :value_proposition_category, strategy: :build
  end
end