# Set up mysql for a redmine site

execute "mysql setup" do
  command "mysql <<EOF
create database redmine;
create user redmine;
grant all privileges on redmine.* to redmine;
flush privileges;
EOF
"
  only_if "mysql mysql < <(echo 'show databases;') | grep -q ^redmine$"
  action :run
end

template "/var/www/redmine/config/database.yml" do
  source "database.yml.erb"
  owner "www-data"
  group "staff"
  mode 0644
  action :create
  not_if "test -d /var/www/redmine/config"
end

