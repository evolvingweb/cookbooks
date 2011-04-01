#
# Cookbook Name:: vim
# Recipe:: default
#

package "vim"

cookbook_file "/etc/vim/vimrc.local" do
  source "vimrc.local"
  mode "0644"
  owner "root"
  group "root"
end
