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

link "/usr/local/bin/drush" do
  to "/usr/local/lib/drush/drush"
end
