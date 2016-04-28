%w(
  git
  wget
  curl
).each do |install|
  package(install) { options '--force-yes' }
end

include_recipe '../cookbooks/porg'
