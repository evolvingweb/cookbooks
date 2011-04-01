#
# Cookbook Name:: seleniumrc
#
# Recipe:: default
#

include_recipe "phpunit"

%w(unzip openjdk-6-jre-headless firefox chromium-browser).each do |pkg|
  package pkg
end

config = node[:seleniumrc]

remote_file config[:download_path] do
  source "http://selenium.googlecode.com/files/selenium-remote-control-#{config[:version]}.zip"
  action :create_if_missing
end

directory config[:dir] do
  owner config[:user]
  group config[:group]
  mode 0755
end

execute "unzip #{config[:download_path]} '#{config[:server]}/*' -d #{config[:dir]}" do
  not_if "test -d #{config[:dir]}/#{config[:server]}"
end

template "/etc/init.d/seleniumrc" do
  source "seleniumrc.erb"
  mode 0755
end

service "seleniumrc" do
  supports :restart => true, :start => true, :stop => true
  action [ :enable, :start ]
end
