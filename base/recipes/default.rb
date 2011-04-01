#
# Cookbook Name:: base
# Recipe:: default
#

package 'language-pack-en-base' if node[:platform] == 'ubuntu'

%w(
  subversion
  htop
  iftop
  emacs23-nox
  php-elisp
  bash-completion
  man-db
  ack-grep
  byobu
).each do |pkg|
  package pkg
end
