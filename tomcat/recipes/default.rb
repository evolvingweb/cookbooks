#
# Cookbook Name:: tomcat
# Recipe:: default
#

include_recipe "java"

package "tomcat6"

service "tomcat" do
  service_name "tomcat6"
  supports :restart => true, :reload => true, :status => true
  action [:enable, :start]
end

config = node[:tomcat]

directory node[:tomcat][:home] do
  owner config[:user]
  group config[:group]
end

template "/etc/default/tomcat6" do
  source "default_tomcat6.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :restart, "service[tomcat]"
end

template "#{config[:config_dir]}/server.xml" do
  source "server.xml.erb"
  mode 0644
  owner config[:user]
  group config[:group]
  notifies :restart, "service[tomcat]"
end

template "#{config[:config_dir]}/tomcat-users.xml" do
  source "tomcat-users.xml.erb"
  mode 0600
  owner config[:user]
  group config[:group]
  notifies :restart, "service[tomcat]"
end
