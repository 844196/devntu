execute 'clone phpmyadmin' do
  cwd '/usr/share'
  command <<-EOS
    wget -O - \
      https://github.com/phpmyadmin/phpmyadmin/archive/#{node['phpmyadmin']['version']}.tar.gz \
      | tar zxvf -
    mv phpmyadmin-#{node['phpmyadmin']['version']} phpmyadmin
  EOS
end

execute 'chmod -R 0755 phpmyadmin' do
  cwd '/usr/share'
end

remote_file '/etc/apache2/sites-available/phpmyadmin.conf'
execute 'a2ensite phpmyadmin'

service 'apache2' do
  action :restart
end
