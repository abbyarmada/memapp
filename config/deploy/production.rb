require 'rvm/capistrano'
server 'example.com', :app, :web, :db, primary: true
set :application, 'member_application'
set :deploy_to, "/home/user/rails_apps/#{application}"
set :bundle_without, [:development, :test, :staging]
set :bundle_flags, '--quiet' # remove --deployment option - as this cannot work if Develop on windows and deploy to Linux"
set :rvm_type, :system
# set :rvm_ruby_string, '1.9.3'
set :rvn_bin_path, '/usr/local/rvm/rubies/ruby-1.9.3-p374/bin'
set :user, 'user'
set :use_sudo, false
before 'deploy:restart', 'deploy:set_permissions'
