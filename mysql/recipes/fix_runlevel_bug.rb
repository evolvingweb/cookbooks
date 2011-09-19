#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2008-2009, Evolving Web, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This recipe makes sure MySQL boots up properly on Proxmox VMs when the VM
# itself reboots.
#
# See https://bugs.launchpad.net/ubuntu/+source/mysql-5.1/+bug/820691
# for the details.
#
# Basically, in /etc/init/mysql.conf, we have these lines:
#
#    start on (net-device-up
#             and local-filesystems
#     and runlevel [2345])
#    stop on runlevel [016]
#
# Which should be replaced with:
#
# start on runlevel [2345]
# stop on runlevel [016]
#
# That's all this recipe does.

include_recipe "mysql::server"

case node[:platform]
when "ubuntu"
  if File.exists? '/etc/init/mysql.conf'
    f = File.open('/etc/init/mysql.conf')
    text = f.read
    ugly_regex = /start on.*net-device-up.*and.local-filesystems.*and.runlevel.\[(\d+)\]\)/m
    if text =~ ugly_regex
      good_text = text.sub(ugly_regex, "start on runlevel [\\1]")
      w = File.open('/etc/init/mysql.conf', 'w')
      w.write(good_text)
    end
  end
end
