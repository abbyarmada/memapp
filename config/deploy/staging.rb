require 'rvm/capistrano'
server 'staging.example.com', :app, :web, :db, primary: true
set :application, 'memapp'
set :deploy_to, "/home/user/rails/#{application}"
set :bundle_without, [:development, :test, :production]
# rvm
set :rvm_type, :system
set :rvm_ruby_string, '1.9.3'
set :application, 'memapp'
#
set :user, 'user'
set :use_sudo, false
