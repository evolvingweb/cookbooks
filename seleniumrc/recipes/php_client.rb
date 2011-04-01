#
# Cookbook Name:: seleniumrc
#
# Recipe:: php_client
#

require_recipe "seleniumrc"

config = node[:seleniumrc]

execute "unzip #{config[:download_path]} '#{config[:php_client]}/*' -d #{config[:dir]}" do
  not_if "test -d #{config[:dir]}/#{config[:php_client]}"
end
