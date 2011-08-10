package 'php5-memcached'

file '/etc/php5/conf.d/memcached.ini' do
  content 'extension=memcached.so'
  owner 'root'
  group 'root'
  mode '0644'
end
