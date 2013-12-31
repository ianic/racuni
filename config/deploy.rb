require 'bundler/capistrano'

set :application, "racuni"

set :repository,  "git@github.com:ianic/racuni.git"     
#set :branch, "novi_railsi"

default_run_options[:pty] = true
set :scm, "git"
set :scm_passphrase, "dsalkjmn" #This is your custom users password
#set :user, "ianic"
set :password, "Dsalkjmn1"

set :use_sudo, false
set :ssh_options, { :forward_agent => true }
                 
set :deploy_to, "/var/apps/racuni"
server "10.0.15.32", :app, :web, :db, :primary => true

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end                       
