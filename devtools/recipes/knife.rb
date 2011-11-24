#
# Cookbook Name:: devtools
# Recipe:: knife
#
# Adds bash autocomplete for knife

template "/etc/bash_autocomplete.d/knife" do
  source "knife"
  notifies :run, resources(:execute => "source /etc/bash_autocomplete.d/knife"), :immediately
end

