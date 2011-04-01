#
# Cookbook Name:: solr
# Definition:: solr_instace
#

# params:
#   home_dir: (string, optional)
#     the solr home directory. chef will create it and set proper permissions.
#   version: (string, optional)
#     solr version (1.3.0, 1.4.0, 1.4.1)
#   conf_dir: (string, optional)
#     the solr config directory. it will be linked to inside the solr home directory.
#     only linked if param is set.
#   tomcat_template: (string, optinal)
#     name of the template for tomcat config file.
#   cookbook: (string, optional)
#     name of the cookbook for the template.

define :solr_instance, :version => "1.4.1" do
  include_recipe "solr::tomcat"

  home_dir = params[:home_dir] || "#{node[:solr][:home]}/#{params[:name]}"
  war_file = solr_war_file params[:version]

  directory home_dir do
    mode 0755
    owner node[:tomcat][:user]
    group node[:tomcat][:group]
    recursive true
  end

  link "#{home_dir}/conf" do
    to params[:conf_dir]
  end if params[:conf_dir]

  tomcat_app params[:name] do
    doc_base war_file
    env "solr/home" => home_dir
    template params[:tomcat_template] if params[:tomcat_template]
    cookbook params[:cookbook]
  end
end
