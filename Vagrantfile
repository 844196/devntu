# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/trusty64'
  config.vm.network 'private_network', ip: '192.168.33.10'
  config.vm.provider(:virtualbox) {|vb| vb.memory = '2048' }

  # set timezone
  config.vm.provision 'shell', :privileged => true, :inline => <<-SHELL
    timedatectl set-timezone Asia/Tokyo
    printf '[mysqld_safe]\ntimezone = JST\n' >> /etc/my.cnf
  SHELL

  # add repository for PHP7
  config.vm.provision 'shell', :privileged => true, :inline => <<-SHELL
    yes '' | add-apt-repository ppa:ondrej/php
    yes '' | add-apt-repository ppa:brightbox/ruby-ng
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
    mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -uroot -proot mysql
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

  # composer
  config.vm.provision 'shell', :privileged => true, :inline => <<-SHELL
    apt-get install -y zip unzip
    curl -sS https://getcomposer.org/installer | php
    mv composer.phar /usr/local/bin/composer
  SHELL

  # enable service
  config.vm.provision 'shell', :privileged => true, :inline => <<-SHELL
    service apache2 restart
    service mysql restart
  SHELL

  # dotfiles
  config.vm.provision 'shell', :privileged => false, :inline => <<-SHELL
    sudo apt-get install -y git zsh vim-gnome paco
    git clone https://github.com/844196/dotfiles /home/vagrant/dotfiles
    /home/vagrant/dotfiles/bootstrap
    /home/vagrant/dotfiles/etc/install_zsh_syntax_highlighting
    sudo chsh -s /bin/zsh vagrant
  SHELL

  # Ruby2.3
  config.vm.provision 'shell', :privileged => true, :inline => <<-SHELL
    apt-get install -y ruby2.3=2.3.0-1bbox2~trusty1
    gem install bundler
  SHELL

  # peco
  config.vm.provision 'shell', :privileged => true, :inline => <<-SHELL
    wget https://github.com/peco/peco/releases/download/v0.3.5/peco_linux_amd64.tar.gz
    tar -zxvf peco_linux_amd64.tar.gz
    (cd peco_linux_amd64; paco -lD "install -pm 755 peco /usr/local/bin")
    rm -rf peco_linux_amd64{,.tar.gz}
  SHELL

  # tmux
  config.vm.provision 'shell', :privileged => true, :inline => <<-SHELL
    apt-get install -y libevent-dev libncurses5-dev xsel
    wget https://github.com/tmux/tmux/releases/download/2.1/tmux-2.1.tar.gz
    tar -zxvf tmux-2.1.tar.gz
    (cd tmux-2.1; ./configure; make; paco -lD "make install")
    rm -rf tmux-2.1{,.tar.gz}
  SHELL

  # SSH keygen
  config.vm.provision 'shell', :privileged => false, :inline => <<-SHELL
    yes '' | ssh-keygen
  SHELL
end
