source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.0.8.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.5.3'
# Use Puma as the app server
gem 'puma', '~> 5.6'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 4.2.0'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.5.1', require: false

gem 'sprockets-rails'
gem 'rexml'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # For generating a self-signed certificate in development.
  gem 'openssl'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'rack-cas'


gem 'geocoder'

# https://github.com/roidrage/lograge
gem 'lograge'
