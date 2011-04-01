#
# Cookbook Name:: glusterfs
# Recipe:: server
#

package "glusterfs-server" do
  action :install
end

service "glusterfs-server" do
  supports :restart => true
  action :enable
end

directory node[:glusterfs][:server][:data_dir] do
  owner "root"
  group "root"
  mode 0755
  action :create
  recursive true
  not_if "test -d #{node[:glusterfs][:server][:data_dir]}"
end

template "/etc/glusterfs/glusterfsd.vol" do
  source "server.config.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources(:service => "glusterfs-server")
end
