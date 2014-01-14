Fog.credentials_path = Rails.root.join('config/fog_credentials.yml')

fog_dir = Rails.env.production? ? 'production-bucket-ipi' : 'dev-bucket-ipi'

CarrierWave.configure do |config|
  config.storage :fog
  config.fog_credentials = { :provider => 'AWS',
     :aws_access_key_id     => ENV['AWS_ACCESS_KEY'],
     :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'] }
  config.fog_directory  =  fog_dir
  config.fog_public     = false
  config.fog_attributes = {'x-amz-server-side-encryption' => 'AES256'}
end

if Rails.env.test?
  CarrierWave.configure do |config|
    config.enable_processing = false
    config.fog_credentials = { :provider => 'AWS' }
  end
end
