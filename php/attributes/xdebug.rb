#
# Cookbook Name:: php
#
# Attributes:: default
#

default[:php][:xdebug][:enable] = 0

default[:php][:xdebug][:profiler][:enable]      = 0
default[:php][:xdebug][:profiler][:output_dir]  = "/tmp"
default[:php][:xdebug][:profiler][:output_name] = "cachegrind.out.%H.%t"
