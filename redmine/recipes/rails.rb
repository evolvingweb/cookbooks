# gems and packages required to run redmine 1.2 on apache

gem_package "rails" do
  version "2.3.11"
end

gem_package "i18n" do
  version "0.4.2"
end

package "libapache2-mod-passenger" do
  action :install
end
