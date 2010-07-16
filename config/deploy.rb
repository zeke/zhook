set :application, "zhook"
set :repository,  "https://wush.net/svn/givezooks/side_projects/zhook/trunk/"

set :copy_strategy, :export
set :deploy_via,    :export
set :scm,           :subversion
set :keep_releases, 3
set :use_sudo, false

after "deploy:update", "deploy:cleanup"

task :production do
  set :rails_env,    'production'
  role :app, "zhook.givezooks.com"
  role :web, "zhook.givezooks.com"
  role :db,  "zhook.givezooks.com", :primary => true
  set :user, 'givezooks'
  set :deploy_to, "/home/rails/#{application}"
end

# Overwriting default tasks
#
namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true }  do
      run '/etc/init.d/mongrel_cluster restart'
  end

  desc "web:disable, update_code, db_rake, restart, web:enable"
  task :long do
    #web.disable
        #disable_web
    default
    # create_svn_tags
    # update_code
    db_rake
    # restart
    #web.enable
        #enable_web
  end
end # namespace deploy

