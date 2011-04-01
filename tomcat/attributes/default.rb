#
# Cookbook Name:: tomcat
# Attributes:: default
#

set[:tomcat][:user] = 'tomcat6'
set[:tomcat][:group] = 'tomcat6'
set[:tomcat][:home] = "/usr/share/tomcat6"
set[:tomcat][:base] = "/var/lib/tomcat6"
set[:tomcat][:config_dir] = "/etc/tomcat6"
set[:tomcat][:context_dir] = "#{tomcat[:config_dir]}/Catalina/localhost"
set[:tomcat][:webapp_dir] = "#{tomcat[:base]}/webapps"

default[:tomcat][:memory] = 386

::Chef::Node.send :include, Opscode::OpenSSL::Password
default[:tomcat][:admin][:username] = "root"
set_unless[:tomcat][:admin][:password] = secure_password

# http
default[:tomcat][:http][:enable] = true
default[:tomcat][:http][:port]   = 8080

# https
default[:tomcat][:https][:enable] = false
default[:tomcat][:https][:port]   = 8443
