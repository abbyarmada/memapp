require "bundler/capistrano"
require 'capistrano/ext/multistage'
set :deploy_via, :remote_cache
#set :scm, :subversion
#set :repository, "http://domain.name.com/svn/branches/production"
#set :branch, "master"
#set :scm_user, "username"
#set :scm_passphrase , "password"
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :stages, ["staging", "production"]
set :default_stage, "staging"
set :keep_releases, 5
# Passenger
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  desc "Correct the file owner to that of the apache process" 
  task :set_permissions, :roles => :app do 
    run "chown -R username.username #{deploy_to}"
  end
end

after "deploy:update", "deploy:cleanup"




