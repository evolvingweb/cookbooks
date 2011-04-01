define :mysql_user, :create => true, :privileges => ["ALL PRIVILEGES"], :host => 'localhost' do
  include_recipe "mysql::server"

  sql_file = "/etc/mysql/grants/#{params[:host]}.#{params[:database]}.#{params[:name]}.sql"
  actn = params[:create] ? "grant" : "revoke"
  cmd_name = "#{actn} #{params[:database]}.* TO #{params[:name]}@#{params[:host]}"

  template sql_file do
    source "user_#{actn}.sql.erb"
    cookbook "mysql"
    owner "root"
    group "root"
    mode 0600
    backup false
    variables :params => params
    notifies :run, "execute[#{cmd_name}]", :immediately
  end

  execute cmd_name do
    command "mysql -u root --password='#{node[:mysql][:server_root_password]}' < #{sql_file}"
    action :nothing
  end
end
