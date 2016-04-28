%w(nodejs npm).each do |install|
  package(install) { options '--force-yes' }
end

execute 'install latest nodejs' do
  command <<-EOS
    npm cache clean
    npm install n -g
    n stable
    ln -sf /usr/local/bin/node /usr/bin/node
  EOS
end

execute 'install bower' do
  command 'npm install bower -g'
end
