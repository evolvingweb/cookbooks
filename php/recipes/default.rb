#
# Cookbook Name:: php
# Recipe:: default
#

include_recipe "apt"

packages = {
  'php5'                => '5.2',
  'php5-cli'            => '5.2',
  'php5-cgi'            => '5.2',
  'php5-dev'            => '5.2',
  'php5-gd'             => '5.2',
  'php5-common'         => '5.2',
  'php-pear'            => '5.2',
  'php5-curl'           => '5.2',
  'php5-mysql'          => '5.2',
  'libapache2-mod-php5' => '5.2',
  'php-apc'             => '3.0'
}

packages.each do |package,version|
  execute "aptitude --assume-yes purge #{package}" do
    not_if "apt-cache policy #{package} | grep 'Installed: #{version}'"
  end 

  file "/etc/apt/preferences.d/#{package}" do
    mode 0644
    owner "root"
    group "root"
    content "Package: #{package}\nPin: release a=karmic\nPin-Priority: 991"
    backup false
  end
end

# Create Karmic source list.
# FIXME: This repo is unsupported and we should discontinue using it. 
template "/etc/apt/sources.list.d/karmic.list" do
  source "karmic.list.erb"
  notifies :run, resources(:execute => "apt-get update"), :immediately
end

execute "hold php5 packages" do
  command "aptitude hold #{packages.keys.join(' ')}"
  action :nothing
end

execute "install php5 packages" do
  command "aptitude -t karmic --assume-yes install #{packages.keys.join(' ')}"
  notifies :run, resources(:execute => "hold php5 packages"), :immediately
end

# SETTINGS

%w(apache2 cli).each do |location|
  template "/etc/php5/#{location}/php.ini" do
    source "php.ini.erb"
    mode 0644
    owner "root"
    group "root"
    variables :memory_limit => node[:php][location.to_sym][:memory_limit]
  end
end

template "/etc/php5/conf.d/apc.ini" do
  source "apc.ini.erb"
  mode 0644
  owner "root"
  group "root"
  variables :shm_size => node[:php][:apc][:shm_size]
end
