maintainer        "Jeff Wallace"
maintainer_email  "jeff@evolvingweb.ca"
license           "Apache 2.0"
description       "Setup GlusterFS servers and clients"
version           "0.1"
recipe            "glusterfs::client", "Sets up a GlusterFS client"
recipe            "glusterfs::server", "Sets up a GlusterFS server"

%w{ubuntu debian}.each do |os|
  supports os
end
