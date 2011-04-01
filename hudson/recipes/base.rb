#
# Cookbook Name:: hudson
# Recipe:: base
#

include_recipe "java"
include_recipe "git"

execute "aptitude update" do
  action :nothing
end

%w(openjdk-6-jre daemon gnupg psmisc).each do |pkg|
  package pkg
end

{
  "/tmp/hudson-ci.org.key" => "http://hudson-ci.org/debian/hudson-ci.org.key",
  "/tmp/hudson.deb" => "http://hudson-ci.org/latest/debian/hudson.deb",
}.each do |dst,src|
  remote_file dst do
    source src
    not_if "dpkg -l | grep hudson"
  end
end

execute "apt-key add /tmp/hudson-ci.org.key" do
  not_if "dpkg -l | grep hudson"
end

execute "dpkg --install /tmp/hudson.deb" do
  notifies :run, resources(:execute => "aptitude update"), :immediately
  not_if "dpkg -l | grep hudson"
end

package "hudson"
