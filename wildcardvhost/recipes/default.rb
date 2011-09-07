#
# Cookbook Name:: wildcardvhost
# Recipe:: default
#
# Copyright 2011, Evolving Web Inc.
#
# All rights reserved.

# *.sage.ewdev.ca should map to
# VirtualDocumentRoot /var/shared/sites/%-4/site

def fqdn_offset(name)
  return (name.split('.').length + 1).to_s
end
vhost_offsets = { :hostname => fqdn_offset(node[:hostname]), :fqdn => fqdn_offset(node[:fqdn]) }

template '/etc/apache2/sites-available/zzz-virtualdocumentroot' do
  source 'virtualdocumentroot.erb'
  mode 0644
  owner 'root'
  group 'root'
  variables :vhost_offsets => vhost_offsets
end

apache_site 'zzz-virtualdocumentroot'
