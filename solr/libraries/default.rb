#
# Cookbook Name:: solr
# Library:: default
#

def solr_war_file(version)
  base     = "apache-solr-#{version}"
  archive  = "#{base}.tgz"
  war      = "#{base}.war"
  war_file = "#{node[:solr][:home]}/#{war}"

  unless File.exists? war_file
    local_file = "/tmp/#{archive}"

    remote_file local_file do
      source "http://#{node[:solr][:mirror]}/#{version}/#{archive}"
      not_if "test -f #{local_file}"
    end

    bash "install solr #{version}" do
      code <<-EOH
      cd /tmp
      tar xzf #{archive}
      cp ./#{base}/dist/#{war} #{war_file}
      EOH
    end
  end

  war_file
end
