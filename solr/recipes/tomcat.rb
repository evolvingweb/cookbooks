#
# Cookbook Name:: solr
# Recipe:: tomcat
#

include_recipe "tomcat"

directory node[:solr][:home] do
  mode 0755
  owner "tomcat6"
  group "tomcat6"
  recursive true
end
