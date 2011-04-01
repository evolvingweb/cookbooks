#
# Cookbook Name:: ganglia
# Recipe:: client
#

package "ganglia-monitor"

service "ganglia-monitor" do
  enabled true
  running true
  pattern "gmond"
end

template "/etc/ganglia/gmond.conf" do
  source "gmond.conf.erb"
  owner "ganglia"
  group "ganglia"
  mode 0644
  backup false
  notifies :restart, "service[ganglia-monitor]"
end

cookbook_file "/usr/local/bin/ganglia_disk_stats.pl" do
  source "ganglia_disk_stats.pl"
  owner "root"
  group "root"
  mode "0755"
end

node[:filesystem].each do |device,options|
  next if options[:mount] != "/" || device == "simfs"
  disk = device.gsub(/\/dev\//, '').gsub(/[0-9]+$/, '')
  cron "gather ganglia I/O statistics for #{disk}" do
    command "/usr/local/bin/ganglia_disk_stats.pl #{disk}"
    minute "*"
  end
end
