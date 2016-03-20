source 'http://rubygems.org'
ruby '2.3.0'
gem 'rails', '~> 4.2.0'
gem 'responders', '~> 2.0'
gem  'mail', '~> 2.6.0'
gem 'paperclip', '~> 4.3.0'
gem 'execjs', '~> 2.6.0'
gem 'therubyracer', :platforms => :ruby
#gem 'capistrano'
gem 'devise', '~> 3.5.0'
gem 'cancan', '~> 1.6.10'
gem 'rubyzip', '~> 1.2.0'
#gem 'zipruby'

#gem install mysql2 --platform=ruby -- '--with-mysql-dir="C:/Program Files/MySQL/MySQL Server 5.5"'#
#gem install mysql2 --platform=ruby -- '--with-mysql-dir="C:/Program Files/MySQL/MySQLC6"'

gem 'will_paginate', '~> 3.1.0'
gem 'gchartrb', :require => 'google_chart'
gem 'prawn', '~> 2.1.0'
gem 'prawn-table', '~> 0.2.2'
gem 'prawnto', '~> 0.1.1'
gem 'puma', '~> 3.2.0'

#gem 'country_select', github: 'stefanpenner/country_select'
#Store the country name in the data base rather than country code.. forked Country Select.
gem 'country_select', github: 'petercunning/country_select'

gem 'formtastic', '~> 3.1.0'
gem 'formtastic-bootstrap' ,:git => 'https://github.com/petercunning/formtastic-bootstrap'
gem 'simple_form', '~> 3.2.0' #, github: 'plataformatec/simple_form'
gem 'jquery-rails', '~> 4.1.1'
gem 'jquery-ui-rails', '~> 5.0.5'


#required for Less /css stuff
#gem 'autoprefixer-rails'
#gem 'bootstrap-datepicker-rails'
#gem 'datetimepicker-rails', :git => 'git://github.com/zpaulovics/datetimepicker-rails.git',  \
#    :branch => 'master', :submodules => true

#for date display
gem 'momentjs-rails', '>=2.7.0'#, :github => 'derekprior/momentjs-rails'
#gem 'bootstrap3-datetimepicker-rails', '~> 4.7.14'


gem 'jquery-turbolinks', '~> 2.1.0'
gem 'turbolinks', '~> 2.5.3'
gem 'nprogress-rails'
gem 'sass-rails', '~> 5.0.4'
gem 'coffee-rails' #, '~> 3.1.1'
gem 'uglifier', '~> 2.7.2'

#bootstrap
#gem 'less-rails'

#gem 'railsstrap'
gem 'bootstrap-sass', '~> 3.3.6'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_20]
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'quiet_assets'
  gem 'hub', :require=>nil
  gem 'rails_layout'
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
  # gem 'debugger'
  gem 'travis'
  gem "bullet"
  gem "web-console", "~> 2.0"
  gem 'pry-remote'
  gem 'pry-stack_explorer'
  gem 'jazz_hands2'
#gem 'pry-debugger'
#gem 'debugger2', :git => "git://github.com/ko1/debugger2.git"
gem "pry-byebug"
   gem 'rubocop', '< 0.36', require: false   # Check code style
   gem 'rubocop-rspec', require: false       # Rspec plugin for rubocop
   gem 'overcommit', require: false
end

group :test, :development  do
#  gem 'pg'
  gem "rspec-rails", "~> 3.4.0"
  gem 'rspec-mocks'
  gem 'factory_girl_rails'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/sprin
  gem 'spring'
  gem 'capybara'
  gem 'cucumber-rails', require: nil
  gem 'cucumber', require: nil
  gem 'spring-commands-cucumber'
  gem 'spring-commands-rspec'
end

group :test do
  gem "sqlite3"
  gem 'faker'
  gem 'launchy'
  gem 'nokogiri'#, '>= 1.3.3'
  gem 'database_cleaner'
  gem 'rspec-activemodel-mocks'
  gem 'selenium-webdriver'
  gem 'codeclimate-test-reporter', require: nil
  gem 'poltergeist'
  gem 'simplecov', :require => false
  gem 'rake'
end

group :test,:production do
  gem 'mysql2'
end

group :production do
  gem 'bugsnag', '~> 4.0.0'
  gem 'rails_12factor', '~> 0.0.3'
  gem 'unicorn', '~> 5.0.1'
end

#rails 4 upgrade gems
#gem 'rails4_upgrade'
#gem 'protected_attributes'
#gem 'rails-observers'
#gem 'actionpack-page_caching'
#gem 'actionpack-action_caching'
#gem 'activerecord-deprecated_finders'
