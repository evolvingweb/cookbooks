#
# Cookbook Name:: hudson
#  
# Attributes:: proxy
#

default[:hudson][:proxy][:cert_file]    = 'hudson.crt'
default[:hudson][:proxy][:key_file]     = 'hudson.key'
default[:hudson][:proxy][:local_port]   = 8080
default[:hudson][:porxy][:local_scheme] = 'https'
