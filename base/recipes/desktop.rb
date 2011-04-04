#
# Cookbook Name:: base
# Recipe:: desktop
#

%w(
  emacs
  gitk
  gitg
).each do |pkg|
  package pkg
end

%w(activexuser activezenity lunchcheck).each do |file|
  cookbook_file "/usr/local/sbin/#{file}" do
    owner "root"
    group "root"
    mode 0700
    backup false
  end
end
