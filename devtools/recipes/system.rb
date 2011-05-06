packages = %w(
  ifstat
  iotop
  linux-tools-common
  linux-tools
  sysstat
  strace
  ltrace
  netcat
  lsof
  whois
  dnsutils
  mlocate
  findutils
)

packages.each do |pkg|
  package pkg
end
