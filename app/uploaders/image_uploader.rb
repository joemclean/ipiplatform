class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWaveDirect::Uploader
  include CarrierWave::MimeTypes
  process :set_content_type
end