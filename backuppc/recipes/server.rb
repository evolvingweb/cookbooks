#
# Cookbook Name:: backuppc
# Recipe:: server
#

config = node[:backuppc][:server]

package "backuppc"

template "#{config[:dirs][:conf]}/config.pl" do
  source "config.pl.erb"
  mode 0640
  owner config[:user]
  group "www-data"
  variables :config => config
end

clients = search(:node, 'recipes:"backuppc::client"') + search(:backups, '*:*')

Dir["#{config[:dirs][:conf]}/*.pl"].each do |filename|
  fqdn = File.basename filename, '.pl'
  unless fqdn == 'config' || clients.any?{ |c| c[:fqdn] == fqdn }
    File.delete filename
    log("Removing dead backuppc client config file [#{filename}]"){ level :info }
  end
end

template "#{config[:dirs][:conf]}/hosts" do
  source "hosts.erb"
  mode 0640
  owner config[:user]
  group "www-data"
  variables :hosts => clients
end

clients.each do |client|
  template "#{config[:dirs][:conf]}/#{client[:fqdn]}.pl" do
    source "client.pl.erb"
    mode 0640
    owner config[:user]
    group "www-data"
    variables :client => client, :config => client[:backuppc][:client]
  end
end

directory "#{config[:dirs][:top]}/.ssh" do
  mode 0700
  owner config[:user]
  group config[:user]
  recursive true
end

%w(id_rsa id_rsa.pub).each do |file|
  cookbook_file "#{config[:dirs][:top]}/.ssh/#{file}" do
    source file
    mode 0600
    owner config[:user]
    group config[:user]
    backup false
  end
end

# TODO get rsa/dsa for data bag nodes
#template "#{config[:dirs][:top]}/.ssh/known_hosts" do
  #source "known_hosts.erb"
  #cookbook "openssh"
  #mode 0440
  #owner config[:user]
  #group config[:user]
#end

link "/etc/apache2/conf.d/backuppc" do
  to "#{config[:dirs][:conf]}/apache.conf"
end

# TODO make backuppc web service sit at root path
# TODO set backuppc htpasswd based on attribute
