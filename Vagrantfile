# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/trusty64'
  config.vm.provider(:virtualbox) {|vb| vb.memory = '2048' }
  # config.vm.network 'public_network'
  config.vm.network 'private_network', :ip => '192.168.33.10'
  config.vm.network 'forwarded_port', :guest => 35729, :host => 35729 # for guard-livereload

  # set timezone
  config.vm.provision 'shell', :privileged => true, :inline => <<-SHELL
    timedatectl set-timezone Asia/Tokyo
  SHELL

  # configure apt repositories
  config.vm.provision 'shell', :privileged => true, :inline => <<-SHELL
    sed -i.bak \
      -e 's%http://archive.ubuntu.com/ubuntu%http://ftp.jaist.ac.jp/pub/Linux/ubuntu%g' \
      -e 's%http://security.ubuntu.com/ubuntu%http://ftp.jaist.ac.jp/pub/Linux/ubuntu%g' \
      /etc/apt/sources.list
    yes '' | add-apt-repository ppa:brightbox/ruby-ng
    apt-get update
  SHELL

  # base setup
  config.vm.provision 'shell', :privileged => true, :inline => <<-SHELL
    apt-get install -y ruby2.3 ruby2.3-dev g++
    gem install bundler itamae
  SHELL

  # cook do
  config.vm.provision 'shell', :privileged => true, :inline => <<-SHELL
    itamae local --node-yaml /vagrant/node.yml \
      /vagrant/kondate/base.rb \
      /vagrant/kondate/lamp.rb \
      /vagrant/kondate/middleware.rb \
      /vagrant/kondate/toolkit.rb
  SHELL

  # dotfiles
  config.vm.provision 'shell', :privileged => false, :inline => <<-SHELL
    git clone https://github.com/844196/dotfiles /home/vagrant/dotfiles
    /home/vagrant/dotfiles/bootstrap
    sudo chsh -s /bin/zsh vagrant
  SHELL
end
