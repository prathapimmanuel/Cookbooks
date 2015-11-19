# Install nodejs package
 package "nodejs" do
  action :install
 end

# Install npm package
 package "npm" do
  action :install
 end

# Install s3cmd 
 package "s3cmd" do
  action :install
 end

# Configure s3cmd 
 node[:s3cmd][:users].each do |user|

  home = user == :root ? "/root" : "/home/#{user}"

  template "s3cfg" do
      path "#{home}/.s3cfg"
      source "s3cfg.erb"
      mode 0655
  end
 end

# Fetch from S3 bucket
 bash 's3_fetch' do
  user 'ec2-user'
  cwd '/home/ec2-user'
  code <<-EOH
  s3cmd get s3://#{node["s3_bucket_filepath"]}
  EOH
 end


# Install subversion
 package "subversion" do
  action :install
 end

# svn checkout 
 bash 'svn_checkout' do
  user 'ec2-user'
  cwd '/home/ec2-user'
  code <<-EOH
  svn checkout --username #{node["svn_username"]} --password '#{node["svn_password"]}' #{node["url"]}
  EOH
 end
