package 'g++'

execute 'download porg' do
  cwd '/tmp'
  command <<-EOS
    wget -O - \
      http://sourceforge.net/projects/porg/files/porg-#{node['porg']['version']}.tar.gz/download \
      | tar zxvf -
  EOS
end

execute 'install porg' do
  cwd "/tmp/porg-#{node['porg']['version']}"
  command <<-EOS
    ./configure --disable-grop
    make
    make install
  EOS
end

execute 'porg management self' do
  cwd "/tmp/porg-#{node['porg']['version']}"
  command 'make logme'
end
