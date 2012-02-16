script "memcache" do
  interpreter "bash"
  # Using -Z to avoid bug http://pear.php.net/bugs/bug.php?id=16606
  code "pecl install -Z memcache"
  user "root"
end

file '/etc/php5/conf.d/memcache.ini' do
  content 'extension=memcache.so'
  owner 'root'
  group 'root'
  mode '0644'
end
