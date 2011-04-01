maintainer       "Evolving Web Inc."
maintainer_email "sysadmin@evolvingweb.ca"
license          "All rights reserved"
description      "Installs/Configures backuppc"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"
recipe           "backuppc::server", "Set up a backuppc server"
recipe           "backuppc::client", "Set up a backuppc client"
