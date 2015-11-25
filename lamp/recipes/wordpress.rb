# apt-get update
 execute "update" do
  command "apt-get update"
 end

# Creating database for wordpress
 bash "create db" do
  user "ubuntu"
  cwd "/home/ubuntu"
  code <<-EOH
   mysql --user="root" --password="we1c@me" --execute="CREATE DATABASE wordpress; CREATE USER wordpressuser@localhost IDENTIFIED BY 'we1c@me';
   GRANT ALL PRIVILEGES ON wordpress.* TO wordpressuser@localhost; FLUSH PRIVILEGES;
   exit"
  EOH
 end

# Install wordpress
  execute "install wordpress" do
   command "wget http://wordpress.org/latest.tar.gz && tar xzvf latest.tar.gz"
  end

# Running update and dependancies
  execute "dependencies" do
   command "apt-get update && apt-get install -y php5-gd libssh2-php"
  end

# Remove wp-config-sample.php
  execute "remove wp-config-sample.php" do
   command "rm /wordpress/wp-config-sample.php"
  end
 
# wp-config.php
  template "/wordpress/wp-config.php" do
   source "wp-config.php.erb"
   mode "0644"
  end

# Rsync for wordpress
  bash "rsync" do
   user "ubuntu"
   cwd "/var/www/html"
   code <<-EOH
    sudo rsync -avP /wordpress/ /var/www/html/    
    sudo chown -R ubuntu:www-data *
    mkdir /var/www/html/wp-content/uploads
    sudo chown -R :www-data /var/www/html/wp-content/uploads
   EOH
 end 
