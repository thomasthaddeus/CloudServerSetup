#!/bin/bash

# Install Capistrano
gem install capistrano capistrano-rvm capistrano-rails capistrano-bundler capistrano3-puma

# Initialize Capistrano in your project
cd /home/devsetup/myapp
cap install

# Replace the Capfile with the one provided in the guide
echo "require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/puma'
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }" > Capfile

# Replace the deploy.rb file with the one provided in the guide
# Make sure to replace the placeholders with your actual values
echo "# config valid for current version and patch releases of Capistrano
lock '~> 3.16.0'

set :application, 'dsclub'
set :repo_url, 'git@example.com:me/my_repo.git'

# Default branch is :master
# ask :branch, \`git rev-parse --abbrev-ref HEAD\`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/dsclub'

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, 'config/database.yml', 'config/secrets.yml'

# Default value for linked_dirs is []
# append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Default value for default_env is {}
# set :default_env, { path: '/opt/ruby/bin:$PATH' }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      invoke 'puma:restart'
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end" > config/deploy.rb

# Replace the production.rb file with the one provided in the guide
# Make sure to replace the placeholders with your actual values
echo "server '143.198.102.62', user: 'dev', roles: 
