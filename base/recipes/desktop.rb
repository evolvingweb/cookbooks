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
