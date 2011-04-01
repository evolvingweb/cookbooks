maintainer        "Evolving Web Inc."
maintainer_email  "sysadmin@evolvingweb.ca"
license           "none"
description       "Installs and configures Selenium RC"
version           "0.1"

%w{ ubuntu debian }.each do |os|
  supports os
end

%w{ php phpunit }.each do |cb|
  depends cb
end
