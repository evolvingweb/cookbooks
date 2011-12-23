#
# Cookbook Name:: php
# Recipe:: php5-3
#


# TODO deprecate this recipe and use the 'version' attribute as a switch in the default.rb recipe.
packages = %w{php5 php5-cli php5-cgi php5-dev php5-gd php5-common php-pear php5-curl php5-mysql php-apc}

packages.each do |pkg|
  package pkg
end
