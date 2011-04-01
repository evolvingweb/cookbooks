#
# Cookbook Name:: xvfb
#
# Recipe:: default
#

package "xvfb" do
  action :install
end

template "/etc/init.d/xvfb" do
  source "xvfb.erb"
  mode 0755
end

service "xvfb" do
  supports :restart => true
  action [ :enable, :start ]
end
