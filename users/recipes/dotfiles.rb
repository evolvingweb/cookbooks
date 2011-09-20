include_recipe "users::default"

users = search :users, node[:users][:groups].map{ |g| "groups:#{g}" }.join(" OR ")

users.each do |u|
  if u['dotfiles']
    home_dir = "/home/#{u['id']}"
    dotfiles = u['dotfiles']
    dotfiles_url = u['dotfiles']['url']

    git "dotfiles" do
      repository dotfiles_url
      destination "#{home_dir}/dotfiles"
      action :sync
    end
  end
end
