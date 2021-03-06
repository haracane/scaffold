include_recipe "centos::nginx"

include_recipe "centos::apache"

[
  "etc/nginx/conf.d/default/vcs.conf",
  "etc/nginx/conf.d/ssl/vcs.conf"
  ].each do |filename|
  filepath = "/#{filename}"
  template filepath do
    source "#{filename}.erb"
    variables(node[:variables])
  end
  file filepath do
    owner "root"
    group "root"
    mode  "0644"
  end
end
