source 'http://rubygems.org'
ruby '2.0.0'
gem 'rails', '~> 3.2.0'
gem  'mail'
gem "paperclip", "~> 3.0"
gem "execjs"
gem 'therubyracer', :platforms => :ruby
gem 'capistrano'
gem 'formtastic'
gem 'devise'

#gem install mysql2 --platform=ruby -- '--with-mysql-dir="C:/Program Files/MySQL/MySQL Server 5.5"'#
#gem install mysql2 --platform=ruby -- '--with-mysql-dir="C:/Program Files/MySQL/MySQLC6"'
gem 'will_paginate'
gem 'gchartrb', :require => 'google_chart'
gem 'prawn'
gem 'prawn-table'
gem 'prawnto'
gem 'rails3-jquery-autocomplete'#, '0.9.0'
gem 'country-select' 
gem 'quiet_assets'

#gem 'rake'

# Needed for the new asset pipeline
group :assets do
  gem 'sass-rails'#,   "~> 3.1.5"
  gem 'coffee-rails'#, "~> 3.1.1"
  gem 'uglifier'#,     ">= 1.0.3"
end
 
# jQuery is the default JavaScript library in Rails 3.1
gem 'jquery-rails'

gem 'turbolinks'



group :test, :development ,:preprod do
  gem "rspec-rails", "~> 2.14.0"
  gem "spring"
   gem 'factory_girl'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end

group :test do 
  gem "sqlite3"
  gem 'faker'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'nokogiri', '>= 1.3.3'
  gem 'zeus'
  gem 'pg'

#  gem 'rspec-activemodel-mocks'
end

group :test,:production do 
  gem 'mysql2' 
end

group :production do 
  gem 'bugsnag'
  gem 'rails_12factor'
  gem 'unicorn'
end
