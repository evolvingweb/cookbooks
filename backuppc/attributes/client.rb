#
# Cookbook Name:: backuppc
# Attributes:: client
#

default[:backuppc][:client][:backup_files][:only]    = %w(/etc /root /home /var)
default[:backuppc][:client][:backup_files][:exclude] = []
default[:backuppc][:client][:blackout_periods]       = []
default[:backuppc][:client][:rsync][:share_name]     = []
