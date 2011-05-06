#
# Cookbook Name:: users
# Recipe:: default
#

gem_package "ruby-shadow"

users = search :users, node[:users][:groups].map{ |g| "groups:#{g}" }.join(" OR ")

# Get groups and members in each group
groups = {}
users.map do |u|
  groupset = u[:groups].kind_of?(Array) ? u[:groups] : [ u[:groups] ]
  groupset.each do |g|
    if groups.include? g
      groups[g] << u[:id]
    else
      groups[g] = [ u[:id] ]
    end
  end
end

users.each do |u|
  home_dir = "/home/#{u['id']}"

  user u['id'] do
    shell u['shell']
    if not u['shadow'].nil? and not u['shadow'].empty?
      password u['shadow']
    end
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

groups.each do |g, users|
  group g do
    members users
  end
end

node[:users][:groups].each do |name|
  group name do
    members search(:users, "groups:#{name}").map{ |u| u['id'] }
  end
end
