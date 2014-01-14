Fog.credentials_path = Rails.root.join('config/fog_credentials.yml')

fog_dir = Rails.env.production? ? 'production-bucket-ipi' : 'dev-bucket-ipi'

CarrierWave.configure do |config|
  config.storage :fog
  config.fog_credentials = { :provider => 'AWS' }
  config.fog_directory  =  fog_dir
  config.fog_public     = false
  config.fog_attributes = {'x-amz-server-side-encryption' => 'AES256'}
end

if Rails.env.test?
  CarrierWave.configure do |config|
    config.enable_processing = false
  end
end
