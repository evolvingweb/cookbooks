#
# Cookbook Name:: backuppc
# Recipe:: client
#

cookbook_file "/usr/local/sbin/mysqldumpall" do
  owner "root"
  group "root"
  mode 0700
end
