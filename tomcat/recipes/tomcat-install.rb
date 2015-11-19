# Running apt-get
#execute "apt-get update" do 
# command "apt-get update"
#end

# Installing java 
package "openjdk-7-jre-headless" do
 action :install
end

# Downloading tomcat6 tar file
#execute "wget tomcat6" do
# command "wget http://mirror.symnds.com/software/Apache/tomcat/tomcat-6/v6.0.44/bin/apache-tomcat-6.0.44.tar.gz"
#end

# Tomcat base file
cookbook_file "/home/immanuel/apache-tomcat-6.0.44.tar.gz" do
 source "apache-tomcat-6.0.44.tar.gz"
 mode "0755"
end

# Installing tomcat 
bash 'extract_tomcat' do
  user 'immanuel'
  cwd '/home/immanuel'
  code <<-EOH
  tar -zxf apache-tomcat-6.0.44.tar.gz
  EOH
end

# Moving tomcat directory
execute "move tomcat" do
 command "mv /home/immanuel/apache-tomcat-6.0.44 /usr/local/tomcat"
end 

# Changing java path
execute "java path" do
 command "export JAVA_HOME=/usr/lib/jvm/java-7-openjdk"
 command "export PATH=$PATH:/usr/lib/jvm/java-7-openjdk/bin"
end

# Starting tomcat
execute "start tomcat" do
 command "/usr/local/tomcat/apache-tomcat-6.0.44/bin/./startup.sh"
end
