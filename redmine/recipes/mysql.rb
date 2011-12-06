# Set up mysql for a redmine site

template "/var/www/redmine/config/database.yml" do
  source "database.yml.erb"
  owner "www-data"
  group "staff"
  mode 0644
  action :nothing
end

script "mysql setup" do
  interpreter "bash"
  code <<-EOF 
    mysql mysql < <(echo 'show databases;') | grep -q ^redmine$ || mysql mysql < <(echo "create database redmine;")

    [ $(mysql mysql < <(echo 'select * from user where user="redmine";') | wc -c) -eq 0 ] && \
    mysql mysql < <(echo 'create user redmine; grant all privileges on redmine.* to redmine; flush privileges;')

    exit 0
EOF

  action :run
end
