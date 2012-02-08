#
# Cookbook Name:: users
# Attributes:: default
#

default[:users][:groups] = %w(sysadmin staff)
default[:users][:external_keys] = []
