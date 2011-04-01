#
# Cookbook Name:: apt
# Attributes:: default
#

if node[:rackspace] && node[:rackspace][:private_ip]
  default[:apt][:debian][:mirror] = "http://mirror.rackspace.com/debian/"
  default[:apt][:ubuntu][:mirror] = "http://mirror.rackspace.com/ubuntu/"
else
  default[:apt][:debian][:mirror] = "http://debian.mirror.iweb.ca/debian/"
  default[:apt][:ubuntu][:mirror] = "http://ubuntu.mirror.iweb.ca/"
end

default[:apt][:debian][:main_repos]     = %w(stable)
default[:apt][:debian][:security_repos] = %w(stable)
