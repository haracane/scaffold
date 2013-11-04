wdir=$(cd $(dirname $0); pwd)
## rubygemsをインストール

## check running user
if [ `whoami` != "root" ] ; then SUDO=sudo; fi

srcdir=~/src
if [ ! -d $srcdir ]; then mkdir -p $srcdir; fi
cd $srcdir

tarball=rubygems-1.8.24.tgz
if [ ! -f $tarball ]; then
  wget http://rubyforge.org/frs/download.php/76073/$tarball
  if [ $? != 0 ]; then exit 1; fi
fi
tar xvfz $tarball
if [ $? != 0 ]; then exit 1; fi
cd rubygems-1.8.24
$SUDO ruby setup.rb 
if [ $? != 0 ]; then exit 1; fi
gem -v
if [ $? != 0 ]; then exit 1; fi
which gem

echo "gem: --no-ri --no-rdoc" > ~/.gemrc
echo "gem: --no-ri --no-rdoc" | $SUDO tee /root/.gemrc

cd $wdir
$SUDO gem install bundler
if [ $? != 0 ]; then exit 1; fi
$SUDO bundle install
if [ $? != 0 ]; then exit 1; fi

$SUDO gem install chef
if [ $? != 0 ]; then exit 1; fi

# sudo gem install cassandra --version 0.12.1
RUBY_HOME=/usr/local/lib/ruby
$SUDO chmod -R 644 $RUBY_HOME/gems/*/gems/thrift_client-*/lib/*/*.rb
$SUDO chmod -R 644 $RUBY_HOME/gems/*/gems/thrift_client-*/lib/*/*/*.rb
