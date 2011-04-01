#
# Cookbook Name:: denyhosts
# Attributes:: default
#

case platform
when "redhat", "centos", "fedora"
  set[:denyhosts][:secure_log] = "/var/log/secure"
  set[:denyhosts][:hosts_deny] = "/etc/hosts.deny"
  set[:denyhosts][:lock_file] = "/var/lock/subsys/denyhosts"
  set[:denyhosts][:work_dir] = "/var/lib/denyhosts"
  set[:denyhosts][:daemon_log] = "/var/log/denyhosts"
when "suse"
  set[:denyhosts][:secure_log] = "/var/log/messages"
  set[:denyhosts][:hosts_deny] = "/etc/hosts.deny"
  set[:denyhosts][:lock_file] = "/tmp/denyhosts.lock"
  set[:denyhosts][:work_dir] = "/var/lib/denyhosts"
  set[:denyhosts][:daemon_log] = "/var/log/denyhosts"
when "osx"
  set[:denyhosts][:secure_log] = "/private/var/log/asl.log"
  set[:denyhosts][:hosts_deny] = "/etc/hosts.deny"
  set[:denyhosts][:lock_file] = "/tmp/denyhosts.lock"
  set[:denyhosts][:work_dir] = "/var/lib/denyhosts"
  set[:denyhosts][:daemon_log] = "/var/log/denyhosts"
when "debian", "ubuntu"
  set[:denyhosts][:secure_log] = "/var/log/auth.log"
  set[:denyhosts][:hosts_deny] = "/etc/hosts.deny"
  set[:denyhosts][:lock_file] = "/var/run/denyhosts.pid"
  set[:denyhosts][:work_dir] = "/var/lib/denyhosts"
  set[:denyhosts][:daemon_log] = "/var/log/denyhosts"
else
  set[:denyhosts][:secure_log] = "/var/log/auth.log"
  set[:denyhosts][:hosts_deny] = "/etc/hosts.deny"
  set[:denyhosts][:lock_file] = "/var/run/denyhosts.pid"
  set[:denyhosts][:work_dir] = "/var/lib/denyhosts"
  set[:denyhosts][:daemon_log] = "/var/log/denyhosts"
end

default[:denyhosts][:purge_deny] = nil
default[:denyhosts][:purge_threshold] = 0
default[:denyhosts][:block_service] = 'sshd'
default[:denyhosts][:suspicious_login_report_allowed_hosts] = false
default[:denyhosts][:hostname_lookup] = true
default[:denyhosts][:syslog_report] = false
default[:denyhosts][:daemon][:log_time_format] = nil
default[:denyhosts][:daemon][:log_message_format] = nil
default[:denyhosts][:daemon][:sleep] = '30s'
default[:denyhosts][:daemon][:purge] = '1h'

default[:denyhosts][:plugin][:deny] = "/bin/true"
default[:denyhosts][:plugin][:purge] = "/bin/true"

default[:denyhosts][:threshold][:valid] = 10
default[:denyhosts][:threshold][:invalid] = 10
default[:denyhosts][:threshold][:root] = 5
default[:denyhosts][:threshold][:restricted] = 5

default[:denyhosts][:age_reset][:valid] = '5d'
default[:denyhosts][:age_reset][:invalid] = '10d'
default[:denyhosts][:age_reset][:root] = '25d'
default[:denyhosts][:age_reset][:restricted] = '25d'
default[:denyhosts][:age_reset_on_success] = false

default[:denyhosts][:smtp][:to] = ['denyhosts@evolvingweb.ca']
default[:denyhosts][:smtp][:from] = 'DenyHosts'
default[:denyhosts][:smtp][:subject] = 'DenyHosts Report'
default[:denyhosts][:smtp][:host] = 'localhost'
default[:denyhosts][:smtp][:port] = 25
default[:denyhosts][:smtp][:username] = nil
default[:denyhosts][:smtp][:password] = nil
default[:denyhosts][:smtp][:date_format] = nil

default[:denyhosts][:allowed_hosts] = ['127.0.0.1']
default[:denyhosts][:allowed_hosts_hostname_lookup] = false
