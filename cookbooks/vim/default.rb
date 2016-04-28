execute 'install build dependencies package' do
  command <<-EOS
    apt-get build-dep -y vim
    apt-get install -y lua5.2 liblua5.2-dev luajit libluajit-5.1
  EOS
end

execute 'clone vim' do
  cwd '/tmp'
  command <<-EOS
    wget -O - \
      https://github.com/vim/vim/archive/v#{node['vim']['version']}.tar.gz \
      | tar zxvf -
  EOS
end

execute 'configure' do
  cwd "/tmp/vim-#{node['vim']['version']}"
  command <<-EOS
    ./configure \
      --with-features=huge \
      --enable-luainterp \
      --with-luajit \
      --enable-fail-if-missing
  EOS
end

execute 'install' do
  cwd "/tmp/vim-#{node['vim']['version']}"
  command <<-EOS
    porg -lp \
      "vim-#{node['vim']['version']}" \
      "make install"
  EOS
end
