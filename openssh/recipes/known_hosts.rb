#
# Cookbook Name:: openssh
# Recipe:: known_hosts
#

sleep 2

template "/etc/ssh/ssh_known_hosts" do
  source "known_hosts.erb"
  mode 0440
  owner "root"
  group "root"
  backup false
  variables :nodes => search(:node, '*:*')
end
