#
# Cookbook Name:: php
# Recipe:: php5-3
#

cookbook_file "/etc/apt/sources.list.d/php-5-3-fpm-lucid.list" do
  source "php-5-3-fpm-lucid.list"
  owner "root"
  group "root"
  notifies :run, "execute[prepare-php-repo]", :immediately
end

execute "prepare-php-repo" do
  command "apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C && apt-get update"
end

packages = %w{php5 php5-cli php5-cgi php5-dev php5-gd php5-common php-pear php5-curl php5-mysql php-apc php5-fpm}

packages.each do |pkg|
  package pkg
end
