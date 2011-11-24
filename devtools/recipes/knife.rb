#
# Cookbook Name:: devtools
# Recipe:: knife
#
# Adds bash autocomplete for knife

file "/etc/bash_completion.d/knife" do
  mode 0644
  owner "root"
  group "root"
end

# execute "source knife" do
#   command "source /etc/bash_completion.d/knife"
# end

