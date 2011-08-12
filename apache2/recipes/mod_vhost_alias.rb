#
# Cookbook Name:: apache2
# Recipe:: rpaf 
#

package "libapache2-mod-vhost-hash-alias" do
  action :install
end

apache_module "vhost_alias"
