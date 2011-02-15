set :application, "banking"
set :repository, "git@github.com:JaneKaren/Banking.git"
set :scm, "git"

role :web, "server3.railshosting.cz"
role :app, "server3.railshosting.cz"
role :db,  "server3.railshosting.cz", :primary => true

set :deploy_to, "/home/banking/app/"
set :user, "banking"

set :use_sudo, false

task :after_update_code, :roles => [:app, :db] do
  run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
end

namespace :deploy do
  task :start, :roles => :app do
  end
end

namespace :deploy do
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after "deploy:update_code", "bundler:bundle_new_release" 
namespace :bundler do  
  task :create_symlink, :roles => :app do
    set :bundle_dir, File.join(release_path, 'vendor/bundle')

    shared_dir = File.join(shared_path, 'bundle')
    run "if [ -d #{bundle_dir} ]; then rm -rf #{bundle_dir}; fi" # in the event it already exists..?
    run("mkdir -p #{shared_dir} && ln -s #{shared_dir} #{bundle_dir}")
  end

  task :bundle_new_release, :roles => :app do
    bundler.create_symlink
    run "cd #{release_path} ; RB_USER_INSTALL=1 bundle install --path #{bundle_dir} --deployment" 
  end
end
