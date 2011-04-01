#
# Cookbook Name:: tomcat
# Definition:: tomcat_app
#

define :tomcat_app, :template => "tomcat_app.xml.erb", :cookbook => "tomcat", :remote_allow => '192\.168\.2\.[0-9]+,127\.0\.0\.1' do
  include_recipe "tomcat"

  template "#{node[:tomcat][:context_dir]}/#{params[:name]}.xml" do
    source params[:template]
    owner node[:tomcat][:user]
    group node[:tomcat][:group]
    mode 0644
    cookbook params[:cookbook]
    variables :params => params
    notifies :restart, "service[tomcat]"
  end
end
