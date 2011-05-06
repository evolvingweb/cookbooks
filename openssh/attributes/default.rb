#
# Cookbook Name:: openssh
# Attributes:: default
#

default[:openssh][:port] = 22
default[:openssh][:listen_addresses] = %w(:: 0.0.0.0)
default[:openssh][:host_keys] = %w(/etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key)
# valid values: yes, without-password, forced-commands-only, no
default[:openssh][:permit_root_login] = 'yes'
default[:openssh][:password_logins] = true

# number of client alive requests sshd will send before disconnecting client
default[:openssh][:client_alive][:count_max] = 3
# interval between client alive requests. 0 means such requests are never sent
default[:openssh][:client_alive][:interval] = 0

default[:openssh][:deny_users] = []
default[:openssh][:allow_users] = []
default[:openssh][:deny_groups] = []
default[:openssh][:allow_groups] = []
