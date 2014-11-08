source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.1.6'
gem 'rails-api'
gem 'active_model_serializers', '~> 0.8.0' # converts active models to JSON

# Use postgresql as the database for Active Record
gem 'pg'
gem 'activerecord-session_store', '~> 0.1.0' # stores sessions in activerecord

# JSON parsing
gem 'oj' # JSON parsing library
gem 'oj_mimic_json' # rewrites rails to use oj

# Server
gem 'puma'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# HTTP communication
gem 'faraday', '~> 0.9.0'
gem 'faraday_middleware', '~> 0.9.1'
gem 'typhoeus', '~> 0.6.9'

# Development
group :development do
  gem 'spring' # speeds up rails
  gem 'guard' # file system monitor
  gem 'guard-rspec', require: false # testing framework integration with guard
  gem 'rb-inotify', require: false # library for guard
  gem 'rb-fsevent', require: false # library for guard
  gem 'rb-fchange', require: false # library for guard

  # deployment gems
  gem 'capistrano',  '~> 3.1'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-bundler', '~> 1.1.2'
end

# Development and Test
group :development, :test do
  gem 'rspec-rails', '~> 3.1.0' # testing framework
  gem 'factory_girl_rails' # testing mocks
end
