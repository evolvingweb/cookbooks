define :logrotate, :frequency => "daily", :rotate_count => 5, :rotate_if_empty => false, :missing_ok => true, :compress => true, :enable => true do
  template "/etc/logrotate.d/#{params[:name]}" do
    source "logrotate.conf.erb"
    cookbook "logrotate"
    owner "root"
    group "root"
    mode 0644
    variables :p => params
    backup 0
    action :delete unless params[:enable]
  end
end
