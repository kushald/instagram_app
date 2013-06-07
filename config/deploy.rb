set :stages, %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'
set :application, "instagram_app"
set :repository, "git://github.com/kushald/instagram_app.git"
set :scm, :git

set :deploy_to, "/home/ubuntu/instagram_app"

desc "check production task"
task :check_production do

if stage.to_s == "production"
puts " \n Are you REALLY sure you want to deploy to production?"
puts " \n Enter the password to continue\n "
password = STDIN.gets[0..7] rescue nil
if password != 'mypasswd'
puts "\n !!! WRONG PASSWORD !!!"
exit
end

end

end

before "deploy", "check_production"