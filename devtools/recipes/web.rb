packages = %w(
  exuberant-ctags
  mytop
  apache2-utils
)

packages.each do |pkg|
  package pkg
end
