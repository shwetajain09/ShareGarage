set :application, "ShareGarage"
set :rails_env, "production"
set :branch, "master"
set :location, "52.36.24.124"
set :deploy_to, "/home/ubuntu/ShareGarage"
set :test_log, "log/capistrano.test.log"
set :rvm_type, :user
set :rvm_ruby_string, 'ruby-2.2.3'
set :rvm_path,"/home/ubuntu/.rvm"
set :rvm_bin_path,"/home/ubuntu/.rvm/bin"
role :web, location
role :app, location
role :db, location, :primary => true
set :default_environment, {
 'PATH' => "/home/ubuntu/.rvm/gems/ruby-2.2.3/bin:$PATH"}