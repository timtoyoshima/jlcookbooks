execute "mysql-create-table" do
  command "/usr/bin/mysql -u#{node[:deploy][:myphpapp][:database][:username]} -p#{node[:deploy][:myphpapp][:database][:password]} #{node[:deploy][:myphpapp][:database][:database]} -e'CREATE TABLE #{node[:phpapp][:dbtable]}(
  id UNSIGNED INT NOT NULL AUTO_INCREMENT,
  url VARCHAR(255) NOT NULL,
  caption VARCHAR(255)
  PRIMARY KEY (id)
)'"
  not_if "/usr/bin/mysql -u#{node[:deploy][:myphpapp][:database][:username]} -p#{node[:deploy][:myphpapp][:database][:password]} #{node[:deploy][:myphpapp][:database][:database]} -e'SHOW TABLES' | grep [:phpapp][:dbtable]"
  action :run
end
