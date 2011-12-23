#
# Cookbook Name:: phpmyadmin
# Recipe:: default
#
# Copyright 2010, MoJo Code
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

include_recipe "apache2::default"
include_recipe "mysql::server"
include_recipe "php"

package "phpmyadmin" do
  action :upgrade
end

template "/etc/apache2/conf.d/phpmyadmin" do
  source "apache.conf.erb"
end
