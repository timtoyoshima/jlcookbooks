log node[:myphotoapp][:dbtable].inspect

script "install_composer" do
  interpreter "bash"
  user "root"
  cwd "#{node[:deploy][:myphotoapp][:deploy_to]}/current"
  code <<-EOH
  curl -s https://getcomposer.org/installer | php
  php composer.phar install
  EOH
end


template "#{node[:deploy][:myphotoapp][:deploy_to]}/current/db-connect.php" do
  source "db-connect.php.erb"
  mode 0660
  node[:deploy][:group]

if platform?("ubuntu")
  owner "www-data"
elsif platform?("amazon")   
  owner "apache"
end


  variables(
      :host =>     (node[:deploy][:myphotoapp][:database][:host] rescue nil),
      :user =>     (node[:deploy][:myphotoapp][:database][:username] rescue nil),
      :password => (node[:deploy][:myphotoapp][:database][:password] rescue nil),
      :db =>       (node[:deploy][:myphotoapp][:database][:database] rescue nil),
      :table =>    (node[:myphotoapp][:dbtable] rescue nil),
      :s3bucket => (node[:photobucket] rescue nil)
  )

 only_if do
   File.directory?("#{node[:deploy][:myphotoapp][:deploy_to]}/current")
 end
end
