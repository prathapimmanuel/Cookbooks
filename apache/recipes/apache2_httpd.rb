# Ubuntu Platform 
if node["platform"] == "ubuntu"

# Installing Apache2
 package "#{node["apache_version"]}" do              #default["apache_version"]="apache2=2.2.22-1ubuntu1.9"
 action :install
 end

# Template - Apache2 config file
 template "/etc/apache2/sites-available/default" do          #default["doc_root"]="/home/vagrant"
  source "default.erb"
  mode "0644"
 end

# Service 
 service "apache2" do
  action [:start, :enable]
 end

# Base-files
 cookbook_file "/home/vagrant/index.html" do
  source "index.html"
  mode "0644"
 end

else

# CentOS Platform
node["platform"] == "CentOS"

# Installing Httpd-Apache
 execute "yum install httpd" do 
  command "yum install httpd"
 end

# Httpd Conf file - Template
 template "/etc/httpd/sites-available/default" do
  source "default.erb"
  mode "0644"
 end


# Service 
 service "httpd" do
  action [:start, :enable]
 end
 
# Base-files
 cookbook_file "/home/immanuel/Desktop/index.html" do
  source "index.html"
  mode "0644"
 end
end
