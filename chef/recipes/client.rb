#
# Author:: Joshua Timberman <joshua@opscode.com>
# Author:: Joshua Sierles <joshua@37signals.com>
# Cookbook Name:: chef
# Recipe:: client
#
# Copyright 2008-2010, Opscode, Inc
# Copyright 2009, 37signals
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

root_group = value_for_platform(
  "openbsd" => { "default" => "wheel" },
  "freebsd" => { "default" => "wheel" },
  "default" => "root"
)

ruby_block "reload_client_config" do
  block { Chef::Config.from_file "/etc/chef/client.rb" }
  action :nothing
end

dist_dir = value_for_platform(
  ["ubuntu", "debian"] => { "default" => "debian" },
  ["redhat", "centos", "fedora"] => { "default" => "redhat"}
)
conf_dir = value_for_platform(
  ["ubuntu", "debian"] => { "default" => "default" },
  ["redhat", "centos", "fedora"] => { "default" => "sysconfig"}
)
base_dir = "#{node.languages.ruby.gems_dir}/gems/chef-#{node.chef_packages.chef.version}/distro/#{dist_dir}/etc"

link "/etc/init.d/chef-client" do
  to "#{base_dir}/init.d/chef-client"
end

link "/etc/#{conf_dir}/chef-client" do
  to "#{base_dir}/#{conf_dir}/chef-client"
end

Dir["/home/*/.chef/*.pem"].each do |keyfile|
  file keyfile do
    mode 0600
  end
end

service "chef-client" do
  supports :restart => true
  action [:enable, :start]
end

template "/etc/chef/client.rb" do
  source "client.rb.erb"
  owner "root"
  group root_group
  mode 0644
  notifies :create, resources(:ruby_block => "reload_client_config")
  notifies :restart, "service[chef-client]"
end

log "Add the chef::delete_validation recipe to the run list to remove the #{Chef::Config[:validation_key]}" do
  only_if { File.exists? Chef::Config[:validation_key] }
end

directory "/var/log/chef" do
  owner "root"
  group root_group
  mode 0755
end

include_recipe "logrotate"

logrotate "chef" do
  rotate_count 5
  files "#{node[:chef][:log_dir]}/*.log"
end

include_recipe "chef::ewreporter"
