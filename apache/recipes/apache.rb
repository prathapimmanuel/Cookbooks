# Execute apt-get update
 execute "apt-get update" do 
  command "apt-get update"
 end

# Installing Apache2
 package "apache2" do              
 action :install
 end
 
# Starting apache2 service & adding to bootup 
 service "apache2" do
  action [:start, :enable]
 end

# Add the file for apache to serve
 cookbook_file "/var/www/html/index.html" do
  source "index.html"
  mode "0644"
 end 