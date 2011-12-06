#
# Cookbook Name:: chef-cron
# Recipe:: default
#
# Copyright 2011, Evolving Web Inc.
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


cron "chef-update" do
  minute "13,43"
  user "chef-update"
  home "/home/chef-update"
  shell "/bin/bash"
  command 'knife ssh -C 5 "*:*" "chef-client" -x root'
  action :create
end
