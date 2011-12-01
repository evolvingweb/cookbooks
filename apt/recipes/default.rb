#
# Cookbook Name:: apt
# Recipe:: default
#
# Copyright 2008-2009, Opscode, Inc.
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

e = execute "apt-get update" do
  action :nothing
end

template "/etc/apt/apt.conf.d/90user" do
  source "90user.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :run, "execute[apt-get update]", :immediately
end

# It is a nice convenience for this to run every time, but it seems
# to break things by running before the 90user template gets generated,
# thus always failing to fix the Cache-Limit setting... because the Cache-Limit
# setting isn't set.
# e.run_action(:run)

%w{/var/cache/local /var/cache/local/preseeding}.each do |dirname|
  directory dirname do
    owner "root"
    group "root"
    mode  0755
    action :create
  end
end

template "/etc/apt/sources.list" do
  source "sources.list.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :run, "execute[apt-get update]", :immediately
end
