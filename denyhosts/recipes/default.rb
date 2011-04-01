#
# Cookbook Name:: denyhosts
# Recipe:: default
#

package "denyhosts"

service "denyhosts" do
  supports :restart => true
  action :enable
end

template "/etc/denyhosts.conf" do
  source "denyhosts.conf.erb"
  mode 0640
  owner "root"
  group "root"
  variables :config => node[:denyhosts]
  notifies :restart, resources(:service => "denyhosts")
end

directory node[:denyhosts][:work_dir] do
  mode 0755
  owner "root"
  group "root"
  recursive true
end

template "#{node[:denyhosts][:work_dir]}/allowed-hosts" do
  source "allowed-hosts.erb"
  mode 0640
  owner "root"
  group "root"
  variables :allowed_hosts => node[:denyhosts][:allowed_hosts]
  notifies :restart, resources(:service => "denyhosts")
end

