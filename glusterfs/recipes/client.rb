#
# Cookbook Name:: glusterfs
# Recipe:: client
#

package "glusterfs-client" do
  action :install
end

mount_dir = "#{node[:glusterfs][:client][:mount_dir]}/#{node[:glusterfs][:client][:name]}"

directory mount_dir do
  owner "root"
  group "root"
  mode 0755
  recursive true
  action :create
  not_if "test -d #{mount_dir}"
end

template "gluster-#{node[:glusterfs][:client][:name]}-config" do
  path "/etc/glusterfs/glusterfs.#{node[:glusterfs][:client][:name]}.vol" 
  source "client.config.erb"
  owner "root"
  group "root"
  mode 0644
  variables(
    :params => params,
    :servers => search(:node, "glusterfs_server_name:#{node[:glusterfs][:client][:name]}").map { |n| n["hostname"] }
  )
end

mount mount_dir do
  device "/etc/glusterfs/glusterfs.#{node[:glusterfs][:client][:name]}.vol"
  fstype "glusterfs"
  options "noatime"
  action :enable
  subscribes :remount, resources(:template => "gluster-#{node[:glusterfs][:client][:name]}-config"), :immediately
  supports :remount => true
end
