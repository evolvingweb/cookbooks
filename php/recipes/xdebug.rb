#
# Cookbook Name:: php
# Recipe:: xdebug
#

include_recipe "php"

execute "pecl install xdebug" unless Dir['/usr/lib/php5/*/xdebug.so'].first

template "/etc/php5/conf.d/xdebug.ini" do
  source "xdebug.ini.erb"
  mode 0644
  owner "root"
  group "root"
  variables :config => node[:php][:xdebug]
end
