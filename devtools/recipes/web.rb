packages = %w(
  exuberant-ctags
  mytop
  apache2-utils
  curl
)

packages.each do |pkg|
  package pkg
end
