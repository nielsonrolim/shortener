# frozen_string_literal: true

# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server "example.com", user: "deploy", roles: %w{app db web}, my_property: :my_value
# server "example.com", user: "deploy", roles: %w{app web}, other_property: :other_value
# server "db.example.com", user: "deploy", roles: %w{db}

# Production Servers
server 'soap.lavanderia60minutos.com.br', user: 'deploy', roles: %w[app db web sidekiq_staging], primary: true
# server 'softener.lavanderia60minutos.com.br', user: 'deploy', roles: %w[app db web], primary: false
# server 'foam.lavanderia60minutos.com.br', user: 'deploy', roles: %w[app db web], primary: false

# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}

# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.

set :branch, 'develop'
set :rails_env, 'staging'
set :deploy_to, '/home/deploy/www/shortener_staging'

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"
append :linked_files, "config/credentials/staging.key"

# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server "example.com",
#   user: "user_name",
#   roles: %w{web app},
#   ssh_options: {
#     user: "user_name", # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: "please use keys"
#   }

namespace :deploy do
  desc 'Copy staging key file'
  task :copy_staging_key do
    on roles(:all) do
      execute "mkdir -p #{shared_path}/config/credentials"
      upload! 'config/credentials/staging.key', "#{shared_path}/config/credentials/staging.key"
    end
  end
  before 'check:linked_files', :copy_staging_key

  # desc 'Restart Sidekiq service'
  # task :restart_sidekiq_staging do
  #   on roles(:sidekiq_staging) do
  #     execute 'sudo systemctl restart shortener_sidekiq_staging.service'
  #   end
  # end
  # after :finished, :restart_sidekiq_staging
end
