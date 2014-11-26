source 'http://rubygems.org'
ruby '2.0.0'
gem 'rails', '~> 4.0.0'
gem  'mail'
gem "paperclip"#, "~> 3.0"
gem "execjs"
gem 'therubyracer', :platforms => :ruby
gem 'capistrano'
gem 'devise'
gem 'will_paginate'
gem 'gchartrb', :require => 'google_chart'
gem 'prawn'
gem 'prawn-table'
gem 'prawnto'

#gem 'country_select', github: 'stefanpenner/country_select'
#Store the country name in the data base rather than country code.. forked Country Select.
gem 'country_select', github: 'petercunning/country_select'


#gem 'formtastic' ,'~> 2.3.0.rc2'
gem 'formtastic'#, '~> 3.0.0'
#gem 'formtastic-bootstrap', :git => 'https://github.com/jtomaszewski/formtastic-bootstrap.git'
gem 'formtastic-bootstrap' ,:git => 'https://github.com/petercunning/formtastic-bootstrap'
#, :git => 'https://github.com/0xCCD/formtastic-bootstrap.git'
#see : https://github.com/mjbellantoni/formtastic-bootstrap/pull/110
#gem 'formtastic-bootstrap', '~> 3.0.0'  #'~> 2.1.3'
gem 'simple_form', '~> 3.1.0.rc2' #, github: 'plataformatec/simple_form'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'bootstrap-sass'#, '~> 3.1.1.0'  #'~> 2.3.2.2' #
gem 'jquery-turbolinks'
gem 'turbolinks'
gem 'nprogress-rails'
gem 'sass-rails', '~> 4.0.2'# '~> 3.1.5'
gem 'coffee-rails' #, '~> 3.1.1'
gem 'uglifier'     #, '>= 1.0.3'




group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_20]
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'quiet_assets'
  gem 'hub', :require=>nil
  gem 'rails_layout'
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
  gem 'spring-commands-rspec'
  gem 'debugger'  
end

group :test, :development  do
  gem 'pg'
  gem "rspec-rails", "~> 3.0.0"
  #gem 'factory_girl'
  gem 'factory_girl_rails'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/sprin
  gem 'spring'
end

group :test do
  gem "sqlite3"
  gem 'faker'
  gem 'capybara'
  gem 'launchy'
  gem 'nokogiri'#, '>= 1.3.3'
  gem 'database_cleaner'
  gem 'rspec-activemodel-mocks'
  gem 'selenium-webdriver'
  gem 'codeclimate-test-reporter', require: nil
end

group :test,:production do
  gem 'mysql2'
end

group :production do
  gem 'bugsnag'
  gem 'rails_12factor'
  gem 'unicorn'
end

#rails 4 upgrade gems
gem 'rails4_upgrade'
gem 'protected_attributes'
gem 'rails-observers'
gem 'actionpack-page_caching'
gem 'actionpack-action_caching'
gem 'activerecord-deprecated_finders'







