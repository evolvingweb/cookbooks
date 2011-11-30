#
# Cookbook Name:: devtools
# Recipe:: knife
#
# Adds bash autocomplete for knife

cookbook_file "/etc/bash_completion.d/knife" do
  source "knife"
  mode 00644
  owner "root"
  group "root"
end

