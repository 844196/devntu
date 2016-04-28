package 'automake'

execute 'install dependencies package' do
  command 'apt-get install -y libevent-dev libncurses5-dev xsel'
end

execute 'download tarball' do
  cwd '/tmp'
  command <<-EOS
    wget -O - \
      "https://github.com/tmux/tmux/archive/#{node['tmux']['version']}.tar.gz" \
      | tar zxvf -
  EOS
end

execute 'configure' do
  cwd "/tmp/tmux-#{node['tmux']['version']}"
  command <<-EOS
    ./autogen.sh
    ./configure
  EOS
end

execute 'install' do
  cwd "/tmp/tmux-#{node['tmux']['version']}"
  command <<-EOS
    make
    porg -lp \
      "tmux-#{node['tmux']['version']}" \
      "make install"
  EOS
end
