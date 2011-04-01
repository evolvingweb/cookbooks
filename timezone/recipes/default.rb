#
# Cookbook Name:: timezone
# Recipe:: default
#
# Copyright 2010, James Harton <james@sociable.co.nz>
#
# Apache 2.0 License.
#

package "tzdata"

template "/etc/timezone" do
  source "timezone.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :run, "bash[dpkg-reconfigure tzdata]"
end

bash "dpkg-reconfigure tzdata" do
  user "root"
  code "/usr/sbin/dpkg-reconfigure -f noninteractive tzdata"
  action :nothing
end
