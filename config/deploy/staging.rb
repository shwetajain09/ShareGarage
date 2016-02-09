set :application, "ShareGarage"
set :rails_env, "staging"
set :branch, "master"
set :location, "52.36.24.124"
set :deploy_to, "/home/ubuntu/ShareGarage"
set :test_log, "log/capistrano.test.log"
set :rvm_type, :user
set :rvm_ruby_string, 'ruby 2.2.3'
set :rvm_path,"/home/ubuntu/.rvm"
set :rvm_bin_path,"/home/ubuntu/.rvm/bin"
role :web, location
role :app, location
role :db, location, :primary => true
set :default_environment, {
 'PATH' => "/home/ubuntu/.rvm/gems/ruby-2.2.3@rails4/bin:/home/ubuntu/.rvm/gems/ruby-2.2.3@global/bin:/home/ubuntu/.rvm/rubies/ruby-2.2.3/bin:/home/ubuntu/.rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"}