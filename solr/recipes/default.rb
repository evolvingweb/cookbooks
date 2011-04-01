#
# Cookbook Name:: solr
# Recipe:: default
#

package "solr-tomcat"

service "tomcat6" do
  supports :restart => true
  action [ :enable, :start ]
end

cookbook_file "/etc/solr/solr-tomcat.xml" do
  source "solr-tomcat.xml"
  mode 0644
  owner "root"
  group "root"
  notifies :restart, resources(:service => "tomcat6")
end

template "/etc/default/tomcat6" do
  source "tomcat6.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :restart, resources(:service => "tomcat6")
end

directory "/usr/share/solr/WEB-INF/lib/" do
  mode 0744
  owner "tomcat6"
  group "tomcat6"
  action :create
  recursive true
end

execute "set solr permissions" do
  command "chown -R tomcat6:tomcat6 /usr/share/solr" 
end

link "/usr/share/solr/WEB-INF/lib/lucene-memory.jar" do
  to "/usr/share/java/lucene-memory.jar"
  notifies :restart, resources(:service => "tomcat6")
end
