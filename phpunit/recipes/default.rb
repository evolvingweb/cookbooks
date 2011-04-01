#
# Cookbook Name:: phpunit
#  
# Recipe:: default
#  

include_recipe "php"

execute "pear upgrade pear" do
  not_if "pear info pear | grep 'API Version' | grep 1.9.1"
end

%w(pear.phpunit.de components.ez.no pear.symfony-project.com).each do |channel|
  execute "pear channel-discover #{channel}" do
    not_if "pear list-channels | grep #{channel}"
  end
end

execute "pear install phpunit/PHPUnit" do 
  not_if "pear list -c phpunit | grep PHPUnit"
end
