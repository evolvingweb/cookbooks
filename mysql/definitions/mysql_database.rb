define :mysql_database, :create => true do
  include_recipe "mysql::server"

  mysql_cmd = "mysql -u root --password='#{node[:mysql][:server_root_password]}'"
  check_cmd = "#{mysql_cmd} -e 'show databases' | grep #{params[:name]}"

  if params[:create]
    execute "create '#{params[:name]}' database" do
      command "#{mysql_cmd} -e 'CREATE DATABASE #{params[:name]}'"
      not_if check_cmd
    end
  else
    execute "drop '#{params[:name]}' database" do
      command "#{mysql_cmd} -e 'DROP DATABASE #{params[:name]}'"
      only_if check_cmd
    end
  end
end
