#staging.rb
set :user, "ubuntu"
server "ec2-54-214-251-45.us-west-2.compute.amazonaws.com", :app, :web, :db, :primary => true
ssh_options[:keys] = ["#{ENV['HOME']}/Desktop/Kushalinsta.pem"]