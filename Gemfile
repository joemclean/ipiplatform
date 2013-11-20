source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '4.0.0'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'haml-rails'
gem 'anjlab-bootstrap-rails', :require => 'bootstrap-rails',
                              :github => 'anjlab/bootstrap-rails',
                              :branch => '3.0.0'
gem 'hirb'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'carrierwave'
gem 'carrierwave_direct'
gem 'fog'
gem 'unf'
gem 'kaminari'

group :test, :development do
  gem 'rspec-rails'
  gem 'rspec-mocks'
  gem 'pry-rails'
  gem 'factory_girl_rails'
  gem 'selenium-webdriver'
  gem 'poltergeist'
end

group :test do
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
end

group :development do
  gem 'sqlite3'
  gem 'taps'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'

group :doc do
  gem 'sdoc', require: false
end
