Fog.credentials_path = Rails.root.join('config/fog_credentials.yml')

fog_dir = Rails.env.production? ? ENV['AWS_PROD_BUCKET']: ENV['AWS_DEV_BUCKET']

CarrierWave.configure do |config|
  config.storage :fog
  config.fog_credentials = { :provider => 'AWS',
     :aws_access_key_id     => ENV['AWS_ACCESS_KEY'],
     :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'] }
  config.fog_directory  =  fog_dir
  config.fog_public     = true
  config.fog_attributes = {'x-amz-server-side-encryption' => 'AES256'}
end

if Rails.env.test?
  CarrierWave.configure do |config|
    config.enable_processing = false
    config.fog_credentials = { :provider => 'AWS' }
  end
  Fog.mock!
  connection = Fog::Storage.new(:provider => 'AWS')
  connection.directories.create(:key => ENV['AWS_DEV_BUCKET'])
end
