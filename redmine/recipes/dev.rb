include_recipe "redmine::rails"
include_recipe "redmine::mysql"

execute "reset perms" do
  command "chown -R www-data:staff /var/www"
  command "chmod -R g+w /var/www"
  action :nothing
end

service "apache2" do
  action :nothing
end

execute "enable redmine site" do
  command "a2ensite redmine"
  action :nothing
  notifies :reload, resources(:service => "apache2")
end

git "redmine" do
  repository node[:repository]
  reference node[:branch]
  destination "/var/www/redmine"
  action :checkout
  enable_submodules true
  notifies :create, resources(:template => "/var/www/redmine/config/database.yml")
  notifies :run, resources(:execute => "reset perms")
end

template "/etc/apache2/sites-available/redmine" do
  action :create_if_missing
  source "redmine.erb"
  notifies :run, resources(:execute => "enable redmine site")
end

execute "rake database" do
  command "rake generate_session_store"
  command "rake db:migrate"
  # replace this by databse copy once it's working.
  command "yes en | rake redmine:load_default_data"
  not_if "test -z $(\"mysql redmine < <(echo 'show tables;'))\""
end
