execute 'skip mysql password setup option' do
  command <<-"EOS"
    echo 'mysql-server mysql-server/root_password password #{node['mysql']['root_password']}' | debconf-set-selections
    echo 'mysql-server mysql-server/root_password_again password #{node['mysql']['root_password']}' | debconf-set-selections
  EOS
end

package 'mysql-server-5.6'

execute 'configure mysql server timezone' do
  command "mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -uroot -p#{node['mysql']['root_password']} mysql"
end
