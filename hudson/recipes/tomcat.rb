#
# Cookbook Name:: hudson
# Recipe:: tomcat
#  

include_recipe "hudson::base"
include_recipe "tomcat"

service "hudson" do
  action [:disable, :stop]
end

home_dir = "#{node[:tomcat][:home]}/.hudson"

directory home_dir do
  mode 0755
  owner node[:tomcat][:user]
  group node[:tomcat][:group]
  recursive true
end

template "#{home_dir}/.gitconfig" do
  source "gitconfig.erb"
  mode 0644
  owner node[:tomcat][:user]
  group node[:tomcat][:group]
end

directory "#{home_dir}/.ssh" do
  mode 0700
  owner node[:tomcat][:user]
  group node[:tomcat][:group]
end

cookbook_file "hudson private key" do
  path "#{home_dir}/.ssh/id_rsa"
  source "id_rsa"
  mode 0600
  owner node[:tomcat][:user]
  group node[:tomcat][:group]
end

cookbook_file "hudson public key" do
  path "#{home_dir}/.ssh/id_rsa.pub"
  source "id_rsa.pub"
  mode 0644
  owner node[:tomcat][:user]
  group node[:tomcat][:group]
end

execute "remove ROOT webapp" do
  command "rm -rf #{node[:tomcat][:base]}/ROOT"
  action :nothing
end

link "#{node[:tomcat][:base]}/webapps/ROOT.war" do
  to "/usr/share/hudson/hudson.war"
  notifies :run, "execute[remove ROOT webapp]"
  notifies :restart, "service[tomcat]"
end

if node[:tomcat][:https][:enable]
  node.set[:hudson][:proxy][:local_port] = node[:tomcat][:https][:port]
  node.set[:hudson][:proxy][:local_scheme] = 'https'
elsif node[:tomcat][:http][:enable]
  node.set[:hudson][:proxy][:local_port] = node[:tomcat][:http][:port]
  node.set[:hudson][:proxy][:local_scheme] = 'http'
end
