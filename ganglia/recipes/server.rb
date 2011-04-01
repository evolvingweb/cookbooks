#
# Cookbook Name:: ganglia
# Recipe:: server
#

include_recipe "apache2"

%w(gmetad ganglia-webfrontend).each do |pkg|
  package pkg
end

service "gmetad" do
  enabled true
end

# i'm not sure why Hash.new([]) doesn't work here
cluster_nodes = {}
search(:node, 'ganglia:[* TO *]').each do |n|
  cluster_nodes[n[:ganglia][:cluster_name]] ||= []
  cluster_nodes[n[:ganglia][:cluster_name]] << n[:fqdn]
end

template "/etc/ganglia/gmetad.conf" do
  source "gmetad.conf.erb"
  owner "ganglia"
  group "ganglia"
  mode 0644
  backup false
  variables :cluster_nodes => cluster_nodes
  notifies :restart, "service[gmetad]"
end

directory "/var/lib/ganglia/rrds" do
  owner "ganglia"
  group "ganglia"
end

link "/etc/apache2/conf.d/ganglia" do
  to "/etc/ganglia-webfrontend/apache.conf"
  notifies :restart, "service[apache2]"
end
