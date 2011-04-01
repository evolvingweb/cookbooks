#
# Cookbook Name:: seleniumrc
#  
# Attributes:: default
#

# these two attributes are VERY codependent
default[:seleniumrc][:version]            = "1.0.3"
default[:seleniumrc][:php_client_version] = "1.0.1"

default[:seleniumrc][:dir]                = "/usr/share/seleniumrc"
default[:seleniumrc][:user]               = "root"
default[:seleniumrc][:group]              = "root"
default[:seleniumrc][:java_bin]           = "/usr/bin/java"
default[:seleniumrc][:memory]             = 128
default[:seleniumrc][:pid_file]           = "/var/run/selenium.pid"

set[:seleniumrc][:server]     = "selenium-server-#{node[:seleniumrc][:version]}"
set[:seleniumrc][:php_client] = "selenium-php-client-driver-#{node[:seleniumrc][:php_client_version]}"
set[:seleniumrc][:download_path] = "/tmp/seleniumrc-#{node[:seleniumrc][:version]}.zip"
