include_recipe "yum::epel"

package "unison" do
  action :install
end

