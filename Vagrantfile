# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/trusty64'
  config.vm.network 'private_network', ip: '192.168.33.10'

  config.vm.provider :virtualbox do |vb|
    vb.memory = '2048'
  end

  # add repository for PHP7 and phpMyAdmin
  config.vm.provision 'shell', :privileged => true, :inline => <<-SHELL
    yes '' | add-apt-repository ppa:ondrej/php
  SHELL

  # apt-get update
  config.vm.provision 'shell', :privileged => true, :inline => <<-SHELL
    apt-get update
  SHELL

  # apache
  config.vm.provision 'shell', :privileged => true, :inline => <<-SHELL
    apt-get install -y apache2=2.4.7-1ubuntu4.9
  SHELL

  # mysql
  config.vm.provision 'shell', :privileged => true, :inline => <<-SHELL
    debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
    debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
    apt-get install -y mysql-server-5.6=5.6.28-0ubuntu0.14.04.1
  SHELL

  # php7 and modules
  config.vm.provision 'shell', :privileged => true, :inline => <<-SHELL
    apt-get install -y \
      php7.0=7.0.5-3+donate.sury.org~trusty+1 \
      php7.0-mcrypt=7.0.5-3+donate.sury.org~trusty+1 \
      php7.0-intl=7.0.5-3+donate.sury.org~trusty+1 \
      php7.0-mbstring=7.0.5-3+donate.sury.org~trusty+1 \
      php7.0-mysql=7.0.5-3+donate.sury.org~trusty+1 \
      php7.0-mysql=7.0.5-3+donate.sury.org~trusty+1 \
      php-gettext=1.0.11-2+deb.sury.org~trusty+1 \
      libapache2-mod-php7.0=7.0.5-3+donate.sury.org~trusty+1
  SHELL

  # phpMyAdmin
  config.vm.provision 'shell', :privileged => true, :inline => <<-SHELL
    debconf-set-selections <<< 'phpmyadmin phpmyadmin/dbconfig-install boolean true'
    debconf-set-selections <<< 'phpmyadmin phpmyadmin/app-password-confirm password root'
    debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/admin-pass password root'
    debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/app-pass password root'
    debconf-set-selections <<< 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2'
    apt-get install -y phpmyadmin=4:4.0.10-1
  SHELL

  # enable service
  config.vm.provision 'shell', :privileged => true, :inline => <<-SHELL
    service apache2 restart
    service mysql restart
  SHELL
end
