#
# Cookbook Name:: backuppc
# Attributes:: server
#

default[:backuppc][:server][:wakeup_schedule]   = %w(1 2 3 4 5 6 7 20 21 22 23)
default[:backuppc][:server][:max_backups]       = 2
default[:backuppc][:server][:max_user_backups]  = 2
default[:backuppc][:server][:max_pending_cmds]  = 10
default[:backuppc][:server][:max_nightly_jobs]  = 2
default[:backuppc][:server][:nightly_period]    = 2
default[:backuppc][:server][:max_old_log_files] = 14

default[:backuppc][:server][:cmd_paths][:split]      = '/usr/bin/split'
default[:backuppc][:server][:cmd_paths][:par]        = nil
default[:backuppc][:server][:cmd_paths][:cat]        = '/bin/cat'
default[:backuppc][:server][:cmd_paths][:gzip]       = '/bin/gzip'
default[:backuppc][:server][:cmd_paths][:bzip2]      = '/bin/bzip2'
default[:backuppc][:server][:cmd_paths][:smb]        = '/usr/bin/smbclient'
default[:backuppc][:server][:cmd_paths][:ssh]        = '/usr/bin/ssh'
default[:backuppc][:server][:cmd_paths][:sendmail]   = '/usr/sbin/sendmail'

default[:backuppc][:server][:user] = 'backuppc'

default[:backuppc][:server][:dirs][:top]     = '/var/lib/backuppc'
default[:backuppc][:server][:dirs][:conf]    = '/etc/backuppc'
default[:backuppc][:server][:dirs][:log]     = ''
default[:backuppc][:server][:dirs][:install] = '/usr/share/backuppc'
default[:backuppc][:server][:dirs][:cgi]     = '/usr/share/backuppc/cgi-bin'

default[:backuppc][:server][:full][:period]       = '6.97'
default[:backuppc][:server][:full][:keep_cnt]     = %w(1)
default[:backuppc][:server][:full][:keep_cnt_min] = 1
default[:backuppc][:server][:full][:age_max]      = 90

default[:backuppc][:server][:incr][:period]       = '0.97'
default[:backuppc][:server][:incr][:keep_cnt]     = 3
default[:backuppc][:server][:incr][:keep_cnt_min] = 1
default[:backuppc][:server][:incr][:age_max]      = 30
default[:backuppc][:server][:incr][:levels]       = %w(1 2 3)

# 0 => enabled, 1 => only cgi requests, 2 => off
default[:backuppc][:server][:disable] = 0
default[:backuppc][:server][:xfer_method] = 'rsync'

default[:backuppc][:server][:backup_files][:only]    = %w(/etc /root /home /var)
default[:backuppc][:server][:backup_files][:exclude] = []

# array contains hashes ie. { :begin => 7, :end => 8, :days => %w(1 2 3 4) }
default[:backuppc][:server][:blackout_periods] = []

default[:backuppc][:server][:rsync][:path]          = '/usr/bin/rsync'
default[:backuppc][:server][:rsync][:cmd][:client]  = '$sshPath -q -x -l root $host $rsyncPath $argList+'
default[:backuppc][:server][:rsync][:cmd][:restore] = '$sshPath -q -x -l root $host $rsyncPath $argList+'
default[:backuppc][:server][:rsync][:share_name]    = %w(/)
default[:backuppc][:server][:rsync][:args]          = %w(--numeric-ids --perms --owner --group -D --links --hard-links --times --block-size=2048 --recursive --one-file-system) 
default[:backuppc][:server][:rsync][:restore_args]  = %w(--numeric-ids --perms --owner --group -D --links --hard-links --times --block-size=2048 --recursive --ignore-times --one-file-system) 

default[:backuppc][:server][:ping][:path]     = '/bin/ping'
default[:backuppc][:server][:ping][:cmd]      = '$pingPath -c 1 $host'
default[:backuppc][:server][:ping][:max_msec] = '400'

default[:backuppc][:server][:dump_pre_user_cmd] = '$sshPath -q root@$host /usr/local/sbin/mysqldumpall'
