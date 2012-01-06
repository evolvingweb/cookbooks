
include_recipe "users::default"

users = search :users, node[:users][:groups].map{ |g| "groups:#{g}" }.join(" OR ")

script "add git keys" do
  interpreter "bash"
  code <<-EOF
    grep -q github ~/.ssh/known_hosts || ssh-keyscan github.com >> ~/.ssh/known_hosts
EOF
end

users.each do |u|
  if u['dotfiles']
    home_dir = "/home/#{u['id']}"
    dotfiles = u['dotfiles']
    dotfiles_url = u['dotfiles']['url']
    dotfiles_branch = u['dotfiles']['branch'] || "master"

    execute "change perms #{u['id']}" do
      command "chown -R #{u['id']}:#{u['id']} #{home_dir}/dotfiles"
      user 0
      action :nothing
    end 

    git "dotfiles" do
      repository  dotfiles_url
      destination "#{home_dir}/dotfiles"
      reference dotfiles_branch
      action :checkout
      enable_submodules true
      notifies :run, resources(:execute => "change perms #{u['id']}"), :immediately
    end


    script "update and install dotfiles" do
      interpreter "bash"
      code <<-EOF
       # These files are actively developed, so we can't have chef doing git reset --hard
       # whenever it pleases. Willy nilly merges aren't much better as they could potentially 
       # mess up working copies, make vim panic, you could lose changes, all sorts of evil.
       #
       # The best solution I can come up with is to just leave the directory alone if the 
       # index or working copy are dirty. Of course this means that you'll have to commit 
       # your changes on a machine before you log out, but that's not too much to ask, is it?
       
       cd #{home_dir}/dotfiles 

       # Chef uses "deploy" branch for SCM resources which is annoying.
       # Incidentally, we also have the awkwardness of HEAD being on the wrong branch...
       git checkout #{dotfiles_branch}
       git branch -d deploy

       # Tags are harmless, right?
       git fetch origin
       git fetch origin --tags
       

       if [ -z "$(git status -u no --short)" ]
       then
        # TODO: What if the dotfiles aren't on master?
        #[ git name-rev --name-only HEAD == "master" ] || git checkout master
        git merge origin/#{dotfiles_branch}
        
        if [ $? -ne 0 ]
        then
          # Bad merge. Forget it. Let the developer sort it out next time they take a look.
          git reset --hard
        else
          # TODO: What do we do if updating submodules fails?
          git submodule sync
          git submodule init
          git submodule update
        fi

        # If there's a setup or install file run it (prefer setup if both exist).
        # Make sure to run it as the user in question!!
        # If you're wondering why root has Tavish's dotfiles on all machines...
        if [ -x ./setup.sh ] 
        then
          su -c "./setup.sh" #{u['id']}
        elif [ -x ./install.sh ] 
        then
          su -c "./install.sh" #{u['id']}
        fi
      fi
      
      # Chef doesn't like non-zero exit status. Hopefully we've done enough checking above.
      # If you haven't got a setup file or it fails then that's your own problem.
      exit 0
EOF
      notifies :run, resources(:execute => "change perms #{u['id']}")
    end

  end
end
