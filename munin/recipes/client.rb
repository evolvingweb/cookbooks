#
# Cookbook Name:: munin
# Recipe:: client
#
# Copyright 2010, Opscode, Inc.
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
#

%w(munin-node munin-plugins-extra).each do |pkg|
  package pkg
end

service "munin-node" do
  supports :restart => true
  action :enable
end

munin_servers = search(:node, 'recipes:"munin::server"').map{ |n| n[:ipaddress] } + node[:munin][:allow_ips]

template "/etc/munin/munin-node.conf" do
  source "munin-node.conf.erb"
  mode 0644
  variables :munin_servers => munin_servers
  notifies :restart, "service[munin-node]"
end

node[:munin][:plugins].each do |plugin|
  munin_plugin plugin
end
