execute "mysql-create-table" do
  command "/usr/bin/mysql -u#{node[:deploy][:myphotoapp][:database][:username]} -p#{node[:deploy][:myphotoapp][:database][:password]} #{node[:deploy][:myphotoapp][:database][:database]} -e'CREATE TABLE #{node[:phpapp][:dbtable]}(
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  author VARCHAR(63) NOT NULL,
  message TEXT,
  PRIMARY KEY (id)
)'"
  not_if "/usr/bin/mysql -u#{node[:deploy][:myphotoapp][:database][:username]} -p#{node[:deploy][:myphotoapp][:database][:password]} #{node[:deploy][:myphotoapp][:database][:database]} -e'SHOW TABLES' | grep [:phpapp][:dbtable]"
  action :run
end
