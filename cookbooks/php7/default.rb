execute 'add php7 repository for apt' do
  command <<-EOS
    yes '' | add-apt-repository ppa:ondrej/php
    apt-get update
  EOS
end

%w(
  php7.0
  php7.0-mcrypt
  php7.0-intl
  php7.0-mbstring
  php7.0-mysql
  php-gettext
  libapache2-mod-php7.0
).each do |install|
  package(install) { options '--force-yes' }
end
