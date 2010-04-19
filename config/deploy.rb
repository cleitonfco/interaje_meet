set :application, "interaje"
set :keep_releases, 5
 
# git options
set :scm, "git"
set :repository, "git@github.com:cleitonfco/interaje_meet.git"
set :branch, "master"
set :deploy_via, :remote_cache

# deploy credentials
set :user, "interaje"
set :deploy_to, "/home/#{user}/subdomains/app"
set :use_sudo, false

# server definitions
set :servers, "67.23.79.71"
role :app, servers
role :web, servers
role :db,  servers, :primary => true

default_run_options[:pty] = true

# working with Passenger
namespace :deploy do
  
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    # run "chown interaje.www-data -R #{deploy_to}"
    run "touch #{current_path}/tmp/restart.txt"
  end
 
  [:start, :stop].each do |t|
    desc "don't need #{t} task with mod_rails"
    task t, :roles => :app do
      # run "chown interaje.www-data -R #{deploy_to}"
      run "touch #{current_path}/tmp/restart.txt"
    end
  end
end
 
desc "Link in the production database.yml"
task :after_update_code do
  run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{release_path}/config/database.yml"
end
 
# Only runs this task after deploy:setup
# Used to create a new config/database.yml which differs from the repository
namespace :init do
  desc "Create production-only database.yml"
  task :production_database_yml do
    database_configuration =<<-EOF
production:
  adapter: sqlite3
  database: /home/interaje/subdomains/app/shared/db/production.sqlite3
  pool: 5
  timeout: 5000
EOF
 
    run "mkdir -p #{shared_path}/config"
    put database_configuration, "#{shared_path}/config/database.yml"
  end
end
 
after "deploy:setup", "init:production_database_yml"