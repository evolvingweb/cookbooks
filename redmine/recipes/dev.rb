include_recipe "redmine::rails"
include_recipe "redmine::mysql"

execute "change owner www" do
  command "chown -R www-data:staff /var/www"
  # This is a dev machine, after all.
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
  notifies :run, resources(:execute => "change owner www")
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
  command "rake redmine:load_default_data"
  only_if "test -z $(\"mysql redmine < <(echo 'show tables;'))\""
end
