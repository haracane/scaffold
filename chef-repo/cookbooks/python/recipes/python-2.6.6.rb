include_recipe "epel::epel"

execute "yum install python-devel-2.6.6" do
  user "root"
  command "yum -y install python-devel-2.6.6"
end
