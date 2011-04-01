#
# Cookbook Name:: git
# Recipe:: default
#

package case node[:platform]
when "debian"
  "git-core"
when "ubuntu"
  node[:platform_version].to_f >= 10.10 ? "git" : "git-core"
else
  "git"
end
