source 'http://rubygems.org'
ruby '2.0.0'
gem 'rails', '~> 3.2.18'
gem  'mail'
gem "paperclip", "~> 3.0"
gem "execjs"
gem 'therubyracer', :platforms => :ruby
gem 'capistrano'
gem 'devise'
gem 'will_paginate'
gem 'gchartrb', :require => 'google_chart'
gem 'prawn'
gem 'prawn-table'
gem 'prawnto'
gem 'country-select'
#gem 'formtastic' ,'~> 2.3.0.rc2'
gem 'formtastic', '~> 3.0.0'
#gem 'formtastic-bootstrap', :git => 'https://github.com/jtomaszewski/formtastic-bootstrap.git'
gem 'formtastic-bootstrap' ,:git => 'https://github.com/petercunning/formtastic-bootstrap'
#, :git => 'https://github.com/0xCCD/formtastic-bootstrap.git'
#see : https://github.com/mjbellantoni/formtastic-bootstrap/pull/110
#gem 'formtastic-bootstrap', '~> 3.0.0'  #'~> 2.1.3'

gem 'jquery-rails'
#gem 'rails3-jquery-autocomplete'#, '0.9.0'
gem 'jquery-ui-rails'
gem 'bootstrap-sass', "~> 3.1.1"  #'~> 2.3.2.2' #
gem 'bootstrap-generators', '~> 3.1.0'
gem 'jquery-turbolinks'
#gem 'turbolinks_transitions'
gem 'turbolinks'
gem 'nprogress-rails'
#gem install mysql2 --platform=ruby -- '--with-mysql-dir="C:/Program Files/MySQL/MySQL Server 5.5"'#
#gem install mysql2 --platform=ruby -- '--with-mysql-dir="C:/Program Files/MySQL/MySQLC6"'   
gem 'quiet_assets'

#gem 'rake'

# Needed for the new asset pipeline
group :assets do
  gem 'sass-rails'#,   "~> 3.1.5"
  gem 'coffee-rails'#, "~> 3.1.1"
  gem 'uglifier'#,     ">= 1.0.3"
end
 

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
