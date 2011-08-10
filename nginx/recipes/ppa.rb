# Get nginx from the stable ppa

cookbook_file "/etc/apt/sources.list.d/nginx-stable-lucid.list" do
  source "nginx-stable-lucid.list"
  owner "root"
  group "root"
  mode "0644"
  notifies :run, "execute[prepare-nginx-repo]", :immediately
end

execute "prepare-nginx-repo" do
  command "apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C && apt-get update"
end

include_recipe "nginx"
