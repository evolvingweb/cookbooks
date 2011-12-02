
include_recipe "redmine::default"

deploy_revision "redmine" do
  repository node[:repository]
end

