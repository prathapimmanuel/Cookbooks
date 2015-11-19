# Ubuntu 14.04

# Running apt-get update & apt-get upgrade
 execute "update & upgrade" do
  command "apt-get update && apt-get -y upgrade"
 end

# Install Apache2 and PHP
 apt_package ["apache2", "libapache2-mod-php5"] do
  action :install
 end

# Enable Apache Rewrite module
 execute "enable apache rewrite" do
  command "a2enmod rewrite"
 end

# Apache2 config file for document root for sites
 template "/etc/apache2/sites-available/000-default.conf" do      
  source "000-default.conf.erb"
  mode "0644"
 end

# apache2.conf to AllowOverrides setting to use .htaccess files for security
 template "/etc/apache2/apache2.conf" do      
  source "apache2.conf.erb"
  mode "0644"
 end

# Start apache2
 service "apache2" do
  action [:start, :enable]
 end

# Download and uncompress the latest stable release
 bash 'dokuwiki download' do
  user 'ubuntu'
  cwd '/var/www'
  code <<-EOH
   sudo wget http://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz
   sudo tar xvf dokuwiki-stable.tgz
   sudo mv dokuwiki-*/ dokuwiki
  EOH
 end

# Change permissions
 execute "chown dokuwiki" do
  command "chown -R www-data:www-data /var/www/dokuwiki"
 end

# Restart apache2
 service "apache2" do
  action [:restart]
 end

