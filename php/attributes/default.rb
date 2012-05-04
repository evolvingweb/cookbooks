#
# Cookbook Name:: php
#
# Attributes:: default
#

default[:php][:version] = '5.2'

# memory limits
default[:php][:cli][:memory_limit]     = '256M'
default[:php][:apache2][:memory_limit] = '256M'

# file limits
default[:php][:apache2][:max_upload_filesize] = '2M'
default[:php][:apache2][:post_max_size] = '8M'

# error reporting
default[:php][:apache2][:display_errors] = 'Off'
default[:php][:apache2][:log_errors] = 'On'
default[:php][:apache2][:error_log] = 'syslog'

# apc
default[:php][:apc][:shm_size] = '256'
default[:php][:apc][:shm_segments] = '1'
default[:php][:apc][:write_lock] = '1'
