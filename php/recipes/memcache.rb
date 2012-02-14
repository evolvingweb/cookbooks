script "memcache" do
  interpreter "bash"
  code "pecl install memcache"
  user "root"
end

file '/etc/php5/conf.d/memcache.ini' do
  content 'extension=memcache.so'
  owner 'root'
  group 'root'
  mode '0644'
end
