#
# Cookbook Name:: apt
# Recipe:: internal
#

include_recipe "apt"

template "/etc/apt/apt.conf.d/01proxy" do
  source "01proxy.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :run, "execute[apt-get update]", :immediately
end
