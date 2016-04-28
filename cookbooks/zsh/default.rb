package 'zsh'

execute 'clone zsh-syntax-highlighting' do
  cwd '/tmp'
  command <<-EOS
    wget -O - \
      https://github.com/zsh-users/zsh-syntax-highlighting/archive/#{node['zsh-syntax-highlighting']['version']}.tar.gz \
      | tar zxvf -
  EOS
end

execute 'install' do
  cwd "/tmp/zsh-syntax-highlighting-#{node['zsh-syntax-highlighting']['version']}"
  command <<-EOS
    porg -lp \
      "zsh-syntax-highlighting-#{node['zsh-syntax-highlighting']['version']}" \
      "make install"
  EOS
end

file '/etc/zsh/zshrc' do
  action :edit
  block do |zshrc|
    zshrc.concat <<-EOS
      source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    EOS
  end
end
