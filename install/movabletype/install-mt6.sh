cd /tmp

if [ ! -f cpanm ]; then
  sudo wget https://raw.github.com/miyagawa/cpanminus/master/cpanm
fi

sudo yum install -y gd-devel

sudo perl cpanm CGI Image::Size File::Spec CGI::Cookie LWP::UserAgent DBI DBD::mysql \
  DBD::SQLite DBD::SQLite2 \
  IPC::Run Archive::Zip Net::SMTP::TLS Authen::SASL CGI::PSGI \
  Cache::File GD CGI::Parse::PSGI Crypt::DSA \
  IO::Socket::SSL Plack Imager  Net::SMTP::SSL 
if [ $? != 0 ]; then exit 1; fi

# sudo perl cpanm Crypt::SSLeay Image::Magick XMLRPC::Transport::HTTP::Plack

if [ ! -d ~/www/cgi-bin/mt ]; then
  mkdir -p ~/www/cgi-bin/mt
fi

archive=MT-6_0.zip
dirname=MT-6.0

if [ ! -d $dirname ]; then
  unzip $archive
fi

for entity in $(ls $dirname); do
  if [ $entity = mt-static ]; then
    dest=~/www/$entity
  else
    dest=~/www/cgi-bin/mt/$entity
  fi
  if [ -e $dest ]; then
    echo "[skip] $dest already exists" >&2
  else
    echo "[update] create $dest" >&2
    cp -r $dirname/$entity $dest
  fi
done

chmod 755 ~/www/cgi-bin/mt/*.cgi

###
### /etc/nginx/conf.d/mt.confを作成
#server {
#  listen       80;
#  server_name  blog.kajax.net;
#  root /home/pss/www;
#  index index.html index.php;
#  client_max_body_size 20M;
#
#  include /etc/nginx/conf.d/default/perl-fastcgi.conf;
#}

### /etc/nginx/conf.d/default/perl-fastcgi.conf
#location ~ \.cgi($|/) {
#  include fastcgi_params;
#  fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
#  fastcgi_pass   127.0.0.1:8999;
#}

# mysql> create database (データベース名) character set utf8;