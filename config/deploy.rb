require 'bundler/capistrano'

set :user, 'usrlib'
set :domain, 'dev.usrlib.org'
set :project, 'usr-share'
set :application, 'dev.usrlib.org'
set :applicationdir, "/home/#{user}/#{application}"

set :repository,  "git://github.com/makenai/usr-share.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :user, 'usrlib'
role :web, "dev.usrlib.org"                          # Your HTTP server, Apache/etc
role :app, "dev.usrlib.org"                          # This may be the same as your `Web` server
role :db,  "dev.usrlib.org", :primary => true # This is where Rails migrations will run

# deploy config
set :deploy_to, applicationdir
set :deploy_via, :export


# additional settings
default_run_options[:pty] = true  # Forgo errors when deploying from windows
#ssh_options[:keys] = %w(/Path/To/id_rsa)            # If you are using ssh_keys
set :chmod755, "app config db lib public vendor script script/* public/disp*"
set :use_sudo, false

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end