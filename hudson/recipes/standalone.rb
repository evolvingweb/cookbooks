#
# Cookbook Name:: hudson
#
# Recipe:: standalone
#

include_recipe "hudson::base"

service "hudson" do
  supports :restart => true
  action [:enable, :start]
end

cookbook_file "/etc/init.d/hudson" do
  source "hudson.init"
  mode 0755
  owner "root"
  group "root"
end

template "/etc/default/hudson" do
  source "hudson.erb"
  notifies :restart, resources(:service => "hudson")
end

config = node[:hudson]

directory "#{config[:home]}" do
  owner "hudson"
  mode 0755
  recursive true
end

template "#{config[:home]}/.gitconfig" do
  source "gitconfig.erb"
  mode 0644
  owner "hudson"
end

directory "#{config[:home]}/.ssh" do
  mode 0755
  owner "hudson"
end

cookbook_file "hudson private key" do
  path "#{config[:home]}/.ssh/id_rsa"
  source "id_rsa"
  mode 0600
  owner "hudson"
end

cookbook_file "hudson public key" do
  path "#{config[:home]}/.ssh/id_rsa.pub"
  source "id_rsa.pub"
  mode 0644
  owner "hudson"
end

node.set[:hudson][:proxy][:local_port] = node[:hudson][:port]
node.set[:hudson][:proxy][:local_scheme] = 'https'
