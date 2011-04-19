#
# Author:: Joshua Timberman <joshua@opscode.com>
# Author:: Joshua Sierles <joshua@37signals.com>
# Cookbook Name:: chef
# Recipe:: server
#
# Copyright 2008-2009, Opscode, Inc
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

include_recipe "chef::client"

dist_dir = value_for_platform(
  ["ubuntu", "debian"] => { "default" => "debian" },
  ["redhat", "centos", "fedora"] => { "default" => "redhat"}
)
conf_dir = value_for_platform(
  ["ubuntu", "debian"] => { "default" => "default" },
  ["redhat", "centos", "fedora"] => { "default" => "sysconfig"}
)
base_dir = "#{node.languages.ruby.gems_dir}/gems/chef-#{node.chef_packages.chef.version}/distro/#{dist_dir}/etc"

%w{chef-solr chef-solr-indexer chef-server}.each do |svc|
  service svc do
    action :nothing
  end

  link "/etc/init.d/#{svc}" do
    to "#{base_dir}/init.d/#{svc}"
  end
end

if node[:chef][:webui_enabled]
  service "chef-server-webui" do
    action :nothing
  end

  link "/etc/init.d/chef-server-webui" do
    to "#{base_dir}/init.d/chef-server-webui"
  end
end

template "/etc/chef/server.rb" do
  source "server.rb.erb"
  owner "root"
  group root_group
  mode "644"
  if node[:chef][:webui_enabled]
    notifies :restart, resources( :service => [ "chef-solr", "chef-solr-indexer", "chef-server", "chef-server-webui" ]), :delayed
  else
    notifies :restart, resources( :service => [ "chef-solr", "chef-solr-indexer", "chef-server" ]), :delayed
  end
end

http_request "compact chef couchDB" do
  action :post
  url "#{Chef::Config[:couchdb_url]}/chef/_compact"
  only_if do
    begin
      open("#{Chef::Config[:couchdb_url]}/chef")
      JSON::parse(open("#{Chef::Config[:couchdb_url]}/chef").read)["disk_size"] > 100_000_000
    rescue OpenURI::HTTPError
      nil
    end
  end
end

%w(nodes roles registrations clients data_bags data_bag_items users).each do |view|
  http_request "compact chef couchDB view #{view}" do
    action :post
    url "#{Chef::Config[:couchdb_url]}/chef/_compact/#{view}"
    only_if do
      begin
        open("#{Chef::Config[:couchdb_url]}/chef/_design/#{view}/_info")
        JSON::parse(open("#{Chef::Config[:couchdb_url]}/chef/_design/#{view}/_info").read)["view_index"]["disk_size"] > 100_000_000
      rescue OpenURI::HTTPError
        nil
      end
    end
  end
end
