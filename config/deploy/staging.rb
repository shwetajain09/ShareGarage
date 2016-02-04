set :application, "ShareGarage"
set :rails_env, "staging"
set :branch, "master"
set :location, "54.148.69.247"
set :deploy_to, "/home/ubuntu/ShareGarage"
set :test_log, "log/capistrano.test.log"
set :rvm_type, :user
# set :rvm_ruby_string, "ruby-1.9.3-p392"
# set :rvm_path,"/home/ubuntu/.rvm"
# set :rvm_bin_path,"/home/ubuntu/.rvm/bin"
role :web, location
role :app, location
role :db, location, :primary => true
# set :default_environment, {
# 'PATH' => "~/quovantis/.rvm/gems/ruby-1.9.3-p392/bin:/bin:~/quovantis/.rvm/rubies/ruby-1.9.3-p392/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH"
#}