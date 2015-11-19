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

# Import Schema dump
bash 'import_schema' do
  user 'postgres'
  cwd '/var/lib/postgresql'
  code <<-EOH
  s3cmd get s3://#{node["s3_bucket_filepath"]}
  pg_restore -U #{node["postgres_user"]} -d #{node["new_db"]} -s #{node["db_dump"]}
  EOH
end
