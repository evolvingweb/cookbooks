
include_recipe "users::default"

users = search :users, node[:users][:groups].map{ |g| "groups:#{g}" }.join(" OR ")

users.each do |u|
  if u['dotfiles']
    home_dir = "/home/#{u['id']}"
    dotfiles = u['dotfiles']
    dotfiles_url = u['dotfiles']['url']

    execute "change perms #{u['id']}" do
      command "chown -R #{u['id']}:#{u['id']} #{home_dir}/dotfiles"
      action :nothing
    end

    git "dotfiles" do
      repository dotfiles_url
      destination "#{home_dir}/dotfiles"
      reference "master"
      action :sync
      notifies :run, resources(:execute => "change perms #{u['id']}")
    end
  end
end
