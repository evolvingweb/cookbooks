#
# Cookbook Name:: tomcat
# Recipe:: admin
#

include_recipe "tomcat"

package "tomcat6-admin" do
  notifies :restart, "service[tomcat]"
end
