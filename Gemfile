source 'https://rubygems.org'
ruby '2.1.1'

gem 'bootstrap-sass'
gem 'coffee-rails'
gem 'rails', '4.1.1'
gem 'haml-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'bootstrap_form'
gem 'bcrypt-ruby'
gem 'sidekiq'
gem 'unicorn'
gem "sentry-raven", :require => 'raven'
gem 'paratrooper'
gem 'fabrication'
gem 'carrierwave'
gem 'fog'

group :development do
  gem 'sqlite3'
  gem 'pry-nav'
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
  gem "letter_opener"
  gem "debugger"
end

group :development, :test do
  gem 'rspec-rails', '2.99'
  gem 'faker'
  gem 'pry'
  gem 'launchy'
  gem 'capybara-email'
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'guard-rspec'
end

group :test do
  gem 'database_cleaner', '1.2.0'
  gem 'shoulda-matchers',require: false
  gem 'capybara'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

