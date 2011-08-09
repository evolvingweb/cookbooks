#
# Cookbook Name:: php
# Recipe:: php5-3
#

packages = %w{php5 php5-cli php5-cgi php5-dev php5-gd php5-common php-pear php5-curl php5-mysql php-apc}

packages.each do |pkg|
  package pkg
end
