#
# Cookbook Name:: chef
# Recipe:: ewreporter
#
# Copyright 2011, Evolving Web, Inc.
#

# This script sets up a custom report handler
# that creates a CSV log

directory "/var/chef/handlers" do
  owner "root"
  group "root"
  mode 0755
end

cookbook_file "/var/chef/handlers/ewreporter.rb" do
  source "ewreporter.rb"
  owner "root"
  group "root"
  mode 0644
end
