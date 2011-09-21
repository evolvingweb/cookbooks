#
# Cookbook Name:: drush
# Recipe:: default
#

include_recipe "git"

git "/usr/local/lib/drush" do
  repository "http://git.drupal.org/project/drush.git"
  reference "7.x-4.x"
  action :sync
end

execute "drush" do
  command "/usr/local/bin/drush > /dev/null"
  action :nothing
end

link "/usr/local/bin/drush" do
  to "/usr/local/lib/drush/drush"
  # Ensures drush runs when the link is created and only then.
  notifies :run, resources(:execute => "drush")
end

