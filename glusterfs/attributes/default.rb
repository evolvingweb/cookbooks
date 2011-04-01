# glusterfs attributes

# server
set_unless[:glusterfs][:server][:name] = "gluster"
set_unless[:glusterfs][:server][:data_dir] = "/var/glusterfs/data"
set_unless[:glusterfs][:server][:username] = "glusterfs"
set_unless[:glusterfs][:server][:password] = "glusterfs"
set_unless[:glusterfs][:server][:port] = 6996

# client
set_unless[:glusterfs][:client][:name] = "gluster"
set_unless[:glusterfs][:client][:mount_dir] = "/mnt"
set_unless[:glusterfs][:client][:username] = "glusterfs"
set_unless[:glusterfs][:client][:password] = "glusterfs"
set_unless[:glusterfs][:client][:port] = 6996
