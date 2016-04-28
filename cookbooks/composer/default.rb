%w(curl zip unzip).each do |install|
  package(install) { options '--force-yes' }
end

execute 'download composer' do
  cwd '/tmp'
  command 'curl -sS https://getcomposer.org/installer | php'
end

execute 'install composer to /usr/local/bin' do
  cwd '/tmp'
  command <<-EOS
    porg -lp \
      "composer" \
      "install -pm 755 composer.phar /usr/local/bin/composer"
  EOS
end
