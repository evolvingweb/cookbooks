#
# Cookbook Name:: php
# Recipe:: php5-3
#

cookbook_file "/etc/apt/sources.list.d/php-5-3-fpm-lucid.list" do
  source "php-5-3-fpm-lucid.list"
  owner "root"
  group "root"
  mode "0644"
  notifies :run, "execute[prepare-php-repo]", :immediately
end

execute "prepare-php-repo" do
  command "apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C && apt-get update"
end

packages = %w{php5 php5-cli php5-cgi php5-dev php5-gd php5-common php-pear php5-curl php5-mysql php-apc php5-fpm}

packages.each do |pkg|
  package pkg
end

%w(fpm cli).each do |location|
  template "/etc/php5/#{location}/php.ini" do
    source "php.ini.erb"
    mode "0644"
    owner "root"
    group "root"
    variables :memory_limit => node[:php][location.to_sym][:memory_limit]
  end
end

template "/etc/php5/fpm/pool.d/www.conf" do
  source "www.conf.erb"
  mode "0644"
  owner "root"
  group "root"
end

cookbook_file "/etc/php5/fpm/main.conf" do
  source "main.conf"
  mode "0644"
  owner "root"
  group "root"
end

template "/etc/php5/conf.d/apc.ini" do
  source "apc.ini.erb"
  mode 0644
  owner "root"
  group "root"
  variables :shm_size => node[:php][:apc][:shm_size]
end
