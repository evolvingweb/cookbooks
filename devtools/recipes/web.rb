# This isn't really the place for ctags, cscope, or mytop, but it will do for now.
packages = %w(
  cscope
  exuberant-ctags
  mytop
  apache2-utils
  curl
)

packages.each do |pkg|
  package pkg
end
