execute 'download' do
  cwd '/tmp'
  command <<-EOS
    wget -O - \
      https://github.com/peco/peco/releases/download/v#{node['peco']['version']}/peco_linux_amd64.tar.gz \
      | tar zxvf -
  EOS
end

execute 'install' do
  cwd '/tmp/peco_linux_amd64'
  command <<-EOS
    porg -lp \
      "peco-#{node['peco']['version']}" \
      "install -pm 755 peco /usr/local/bin"
  EOS
end
