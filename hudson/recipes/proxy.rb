#
# Cookbook Name:: hudson
#  
# Recipe:: proxy
#  

include_recipe "nginx"

directory "/etc/ssl/#{node[:domain]}" do
  mode 0755
  owner "root"
  group "root"
  recursive true
end

cookbook_file "hudson proxy cert" do
  path "/etc/ssl/#{node[:domain]}/#{node[:hudson][:proxy][:cert_file]}"
  source node[:hudson][:proxy][:cert_file]
end

cookbook_file "hudson proxy key" do
  path "/etc/ssl/#{node[:domain]}/#{node[:hudson][:proxy][:key_file]}"
  source node[:hudson][:proxy][:key_file]
end

template "hudson proxy site" do
  source "nginx_proxy_site.erb"
  path "#{node[:nginx][:dir]}/sites-available/hudson_proxy"
  notifies :restart, resources(:service => "nginx")
end

nginx_site "hudson_proxy" do
  enable true
end

nginx_site "default" do
  enable false
end
