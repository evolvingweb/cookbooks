#
# Cookbook Name:: users
# Recipe:: default
#

search :users, node[:users][:groups].map{ |g| "groups:#{g}" }.join(" OR ") do |u|
  home_dir = "/home/#{u['id']}"

  user u['id'] do
    shell u['shell']
    comment u['comment']
    supports :manage_home => true
    home home_dir
  end

  directory "#{home_dir}/.ssh" do
    owner u['id']
    group u['id']
    mode 0700
    recursive true
  end

  template "#{home_dir}/.ssh/authorized_keys" do
    source "authorized_keys.erb"
    owner u['id']
    group u['id']
    mode 0600
    variables :ssh_keys => u['ssh_keys']
  end
end

node[:users][:groups].each do |name|
  group name do
    members search(:users, "groups:#{name}").map{ |u| u['id'] }
  end
end
