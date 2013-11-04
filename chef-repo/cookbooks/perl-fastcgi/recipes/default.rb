package "perl-CGI" do
  action :install
end

package "perl-FCGI" do
  action :install
end

[
    "usr/bin/fastcgi-wrapper.pl",
    "etc/init.d/perl-fastcgi"
].each do |filename|
  filepath = "/#{filename}"
  template filepath do
    source "#{filename}.erb"
  end
  file filepath do
    owner "root"
    group "root"
    mode  "0755"
  end
end

service "perl-fastcgi" do
  action :enable
end
