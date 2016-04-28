# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/trusty64'
  config.vm.network 'private_network', ip: '192.168.33.10'
  config.vm.network 'forwarded_port', guest: 35729, host: 35729
  config.vm.network 'public_network'
  config.vm.provider(:virtualbox) {|vb| vb.memory = '2048' }

  # set timezone
  config.vm.provision 'shell', :privileged => true, :inline => <<-SHELL
    timedatectl set-timezone Asia/Tokyo
    printf '[mysqld_safe]\ntimezone = JST\n' >> /etc/my.cnf
  SHELL

  # add repository for PHP7
  config.vm.provision 'shell', :privileged => true, :inline => <<-SHELL
    yes '' | add-apt-repository ppa:ondrej/php
  SHELL

  # apt-get update
  config.vm.provision 'shell', :privileged => true, :inline => <<-SHELL
    apt-get update
  SHELL

  # apache
  config.vm.provision 'shell', :privileged => true, :inline => <<-SHELL
    apt-get install -y apache2
  SHELL

  # mysql
  config.vm.provision 'shell', :privileged => true, :inline => <<-SHELL
    debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
    debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
    apt-get install -y mysql-server-5.6
    mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -uroot -proot mysql
  SHELL

  # php7 and modules
  config.vm.provision 'shell', :privileged => true, :inline => <<-SHELL
    apt-get install -y \
      php7.0 \
      php7.0-mcrypt \
      php7.0-intl \
      php7.0-mbstring \
      php7.0-mysql \
      php-gettext \
      libapache2-mod-php7.0
  SHELL

  # composer
  config.vm.provision 'shell', :privileged => true, :inline => <<-SHELL
    apt-get install -y zip unzip
    curl -sS https://getcomposer.org/installer | php
    mv composer.phar /usr/local/bin/composer
  SHELL

  # phpMyAdmin
  config.vm.provision 'shell', :privileged => true, :inline => <<-SHELL
    cd /usr/share
    wget https://files.phpmyadmin.net/phpMyAdmin/4.5.4.1/phpMyAdmin-4.5.4.1-all-languages.zip
    unzip phpMyAdmin-4.5.4.1-all-languages.zip
    mv phpMyAdmin-4.5.4.1-all-languages phpmyadmin
    chmod -R 0755 phpmyadmin
    tee -a /etc/apache2/sites-available/000-default.conf <<EOF >/dev/null
      Alias /phpmyadmin "/usr/share/phpmyadmin/"
      <Directory "/usr/share/phpmyadmin/">
        Order allow,deny
        Allow from all
        Require all granted
      </Directory>
EOF
    service apache2 restart
  SHELL

  # node.js
  config.vm.provision 'shell', :privileged => true, :inline => <<-SHELL
    apt-get install -y nodejs npm
    npm cache clean
    npm install n -g
    n stable
    ln -sf /usr/local/bin/node /usr/bin/node
  SHELL

  # Bower
  config.vm.provision 'shell', :privileged => true, :inline => <<-SHELL
    npm install bower -g
  SHELL

  # SSH keygen
  config.vm.provision 'shell', :privileged => false, :inline => <<-SHELL
    yes '' | ssh-keygen
  SHELL
end
