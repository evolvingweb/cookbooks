#
# Cookbook Name:: apache2
# Recipe:: rpaf 
#

package "libapache2-mod-rpaf" do
  action :install
end

apache_module "rpaf"
