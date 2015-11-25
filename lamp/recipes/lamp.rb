# Running update
 execute "update" do
  command "apt-get update"
 end

# Setting mysql password
 bash "set mysql password" do
  user "ubuntu"
  cwd "/home/ubuntu"
  code <<-EOH
   sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password we1c@me' 
   sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password we1c@me'
  EOH
 end

# Installing mysql
 package ["mysql-server", "apache2", "libapache2-mod-php5", "libapache2-mod-auth-mysql", "php5-mysql", "php5", "libapache2-mod-php5", "php5-mcrypt"] do
  action :install
 end

# Activate mysql using command
 execute "mysql_install_db" do
  command "mysql_install_db"
 end

# Add index.php before the index for PHP
  template "/etc/apache2/mods-enabled/dir.conf" do
   source "dir.conf.erb"
   mode "0644"
  end

# a2enmod rewrite & restart apache
  execute "a2enmod" do
   command "a2enmod rewrite && service apache2 restart"
  end

