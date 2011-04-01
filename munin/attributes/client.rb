#
# Cookbook Name:: munin
# Attributes:: client
#

default[:munin][:plugins]        = []
default[:munin][:allow_ips]      = []
default[:munin][:group]          = "default"
default[:munin][:graph][:width]  = 800
default[:munin][:graph][:height] = 300
