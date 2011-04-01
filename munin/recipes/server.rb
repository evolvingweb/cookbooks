#
# Cookbook Name:: munin
# Recipe:: server
#
# Copyright 2010-2011, Opscode, Inc.
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

include_recipe "apache2"
include_recipe "apache2::mod_rewrite"
include_recipe "munin::client"

package "munin"

template "/etc/cron.d/munin" do
  source "munin-cron.erb"
  mode "0644"
  owner "root"
  group "root"
  backup 0
end

munin_nodes = search :node, 'recipes:"munin::client"'

template "/etc/munin/munin.conf" do
  source "munin.conf.erb"
  mode 0644
  variables :munin_nodes => munin_nodes
end

apache_site "000-default" do
  enable false
end

template "#{node[:apache][:dir]}/sites-available/munin" do
  source "apache2.conf.erb"
  mode 0644
  if ::File.symlink?("#{node[:apache][:dir]}/sites-enabled/munin")
    notifies :reload, "service[apache2]"
  end
end

directory node['munin']['docroot'] do
  owner "munin"
  group "munin"
  mode 0755
end

apache_site "munin"
