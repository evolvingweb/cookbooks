#
# Cookbook Name:: ewsolr
# Recipe:: default
#
# Copyright 2012, Evolving Web Inc.
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

# This recipe installs the version of solr specified in the attribute :version.
# It does not remove an old solr install from a different recipe. It will however,
# upon the version number being changed, clean up appropriately.

include_recipe "tomcat"

script "install" do
  interpreter "bash"
  code <<EOF

test [ -f /usr/share/solr/apache-solr-#{node[:solr][:version]}.war ] && exit 0 # Don't reinstall.

wget http://apache.mirror.iweb.ca/lucene/solr/#{node[:solr][:version]}/apache-solr-#{node[:solr][:version]}.tgz -O apache-solr-#{node[:solr][:version]}.tgz
tar -xzf apache-solr-#{node[:solr][:version]}.tgz

cp -fR  apache-solr-#{node[:solr][:version]}/example/solr /usr/share
cp apache-solr-#{node[:solr][:version]}/dist/apache-solr-#{node[:solr][:version]}.war /usr/share/solr/
ln -fs /usr/share/solr/apache-solr-#{node[:solr][:version]}.war solr.war
cp -f apache-solr-#{node[:solr][:version]}/contrib /usr/share/solr
mkdir /usr/share/solr/lib
cp -f apache-solr-#{node[:solr][:version]}/dist/*.jar /usr/share/solr/lib

chown -R tomcat6:tomcat6 /usr/share/solr

rm -rf apache-solr-#{node[:solr][:version]}

exit 0
EOF
end

directory "/etc/solr" do
end

cookbook_file "/etc/solr/solr-tomcat.xml" do
  action :create_if_missing
  source "solr.xml"
end

link "/etc/tomcat6/Catalina/localhost/solr.xml" do
  to "/etc/solr/solr-tomcat.xml"
  owner "tomcat6"
  group "tomcat6"
end

cookbook_file "/etc/solr/tomcat.policy" do
  action :create_if_missing
  source "tomcat.policy"
end

service "tomcat6" do
  action :restart
end
