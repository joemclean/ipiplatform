class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWaveDirect::Uploader
  include CarrierWave::MimeTypes
  process :set_content_type

  def store_path(for_file = filename)
    "uploads/" + self.model.class.name.underscore.pluralize + "/" + self.model.id.to_s + "-" + self.model.name.downcase.gsub(" ", "_")
  end
end