require "rvm/capistrano"
require "bundler/capistrano"

server "192.168.56.102", :web, :app, :db, primary: true

set :application, "bns_app"
set :user, "bns"
set :deploy_to, "/home/#{user}/app/#{application}"
set :use_sudo, false
set :keep_releases, 3

set :scm, "git"
set :repository, "file:///home/#{user}/git/#{application}.git"
set :local_repository, "#{user}@192.168.56.102:git/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy:update_code", "deploy:migrate"
after "deploy", "deploy:cleanup"

namespace :deploy do
  %w[start stop].each do |command|
    desc "#{command} nginx server"
    task command, roles: :app, except: {no_release: true} do
      sudo "#{try_sudo} service nginx #{command}"
    end
  end
  
  desc "restart passenger server"
  task :restart, roles: :app, except: { no_release: true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :setup_config, roles: :app do
    # sudo "ln -nfs #{current_path}/config/nginx.conf /opt/nginx/conf/nginx.conf"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.yml"), "#{shared_path}/config/database.yml"
    run "mkdir -p #{shared_path}/uploads"
    puts "==> IMPORTANT!!! Now edit database.yml in #{shared_path}/config <==="
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "rm -rf #{release_path}/public/uploads"
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/"
  end
  after "deploy:finalize_update", "deploy:symlink_config"
end

