#
# Cookbook Name:: php
# Recipe:: xhprof
#

include_recipe "php"
include_recipe "graphviz"

directory "/var/shared/sites/xhprof/" do
  mode "0755"
  recursive true
end

directory "/var/lib/xhprof/" do
  mode "0755"
  owner "www-data"
  recursive true
end

script "install_xhprof" do
  cwd "/tmp"
  interpreter "bash"
  code <<-EOH
wget http://pecl.php.net/get/xhprof-0.9.2.tgz
tar xvf xhprof-0.9.2.tgz
cd ./xhprof-0.9.2/extension/
phpize
./configure
make
make install
make test
cd ..
cp -r ./xhprof_html /usr/share/php/
cp -r ./xhprof_lib /usr/share/php/
EOH
  not_if "test -d '/usr/share/php/xhprof_html'"
end

link "/var/shared/sites/xhprof/site" do 
  to "/usr/share/php/xhprof_html"
end

cookbook_file "/var/shared/sites/xhprof/header.php" do
    source "header.php"
    mode "0744"
end

template "/var/shared/sites/xhprof/footer.php" do
    source "footer.php"
    mode "0744"
end

cookbook_file "/etc/php5/conf.d/xhprof.ini" do
  source "xhprof.ini"
  mode "0744"
end
