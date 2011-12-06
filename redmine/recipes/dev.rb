include_recipe "redmine::rails"
include_recipe "redmine::mysql"


service "apache2" do
  action :nothing
end

execute "enable redmine site" do
  command "a2ensite redmine"
  action :nothing
  notifies :reload, resources(:service => "apache2"), :immediately
end

script "rake database" do
  interpreter "bash"
  # Not_if doesn't seem to work with complex commands...
  code <<-EOF 
  test -z "$(mysql redmine < <(echo 'show tables;'))" || exit 0
  test -r /var/www/redmine/Rakefile || exit 0

  rake generate_session_store
  rake db:migrate
  # replace this by databse copy once it's working.

  yes en | rake redmine:load_default_data

EOF
  cwd "/var/www/redmine"
  action :nothing
  subscribes :run, resources(:template => "/var/www/redmine/config/database.yml"), :immediately
end

script "reset perms" do
  interpreter "bash"
  code <<-EOF
    test -d /var/www/redmine || exit 0
    chown -R www-data:staff /var/www 
    chmod -R g+w /var/www
EOF
  cwd "/"
  action :nothing
  subscribes :run, resources(:template => "/var/www/redmine/config/database.yml"), :immediately
end

git "redmine" do
  repository node[:repository]
  reference node[:branch]
  destination "/var/www/redmine"
  action :checkout
  enable_submodules true
  notifies :create, resources(:template => "/var/www/redmine/config/database.yml"), :immediately
end

template "/etc/apache2/sites-available/redmine" do
  action :create_if_missing
  source "redmine.erb"
  notifies :run, resources(:execute => "enable redmine site"), :immediately
end

