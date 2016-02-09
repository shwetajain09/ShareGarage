
require "rvm/capistrano"
require "bundler/capistrano"
require 'capistrano/ext/multistage'
set :bundle_dir, "/home/ubuntu/.rvm/gems/ruby-2.2.3"
set :stages, ["staging"]
set :default_stage, 'staging'
set :keep_releases, 3
set :repository, "git@github.com:shwetajain09/ShareGarage.git"
default_run_options[:pty] = true
set :scm, :git
ssh_options[:forward_agent] = true
set :deploy_via, :remote_cache
set :git_enable_submodules, 1
set :user, 'ubuntu'
set :use_sudo, false
namespace :deploy do
task :symlink_directories do
run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
end
task :custom_symlink, :roles => :app do
#run "ln -s #{ shared_path }/database.yml #{ current_path }/config/database.yml"
run "ln -s #{ shared_path }/solr/pids #{ current_path }/solr/pids"
run "ln -s #{ shared_path }/solr/data #{ current_path }/solr/data"
end
desc "Restart Passenger app"
task :restart do
run "#{ try_sudo } touch #{ File.join(current_path, 'tmp', 'restart.txt') }"
end
end
after "deploy", "deploy:symlink_directories","deploy:custom_symlink"#,"deploy:migrate"
after "deploy", "deploy:restart"
after "deploy", "deploy:cleanup"