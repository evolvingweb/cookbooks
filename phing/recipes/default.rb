#
# Cookbook Name:: phing
#
# Recipe:: default
#

include_recipe "php"

channel = "pear.phing.info"
execute "pear channel-discover #{channel}" do
  not_if "pear list-channels | grep #{channel}"
end

execute "pear install phing/phing" do
  not_if "pear list -c phing | grep '^phing '"
end
