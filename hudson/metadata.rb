maintainer        "Evolving Web Inc."
maintainer_email  "sysadmin@evolvingweb.ca"
license           "none"
description       "Sets up Hudson on a Ubuntu server"
version           "0.1"
supports          "ubuntu"

%w( tomcat java nginx git ).each do |dep|
  depends dep
end
