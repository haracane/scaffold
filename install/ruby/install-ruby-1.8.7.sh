wdir=$(cd $(dirname $0); pwd)

## check running user
if [ `whoami` != "root" ] ; then SUDO=sudo; fi

$SUDO yum -y install gcc gcc-c++ openssl-devel zlib-devel libxml2-devel libxslt-devel
if [ $? != 0 ]; then exit 1; fi

srcdir=~/src
if [ ! -d $srcdir ]; then mkdir -p $srcdir; fi
cd $srcdir

cd ~/src
target=ruby-1.8.7-p371
tarball=$target.tar.gz
if [ ! -f $tarball ]; then
  wget ftp://ftp.ruby-lang.org/pub/ruby/1.9/$tarball
  if [ $? != 0 ]; then exit 1; fi
fi
tar xvfz $tarball
if [ $? != 0 ]; then exit 1; fi
cd $target
./configure
if [ $? != 0 ]; then exit 1; fi
make
if [ $? != 0 ]; then exit 1; fi
$SUDO make install
if [ $? != 0 ]; then exit 1; fi

#/usr/bin/rubyが存在していれば削除
$SUDO rm -f /usr/bin/ruby 
$SUDO ln -s /usr/local/bin/ruby /usr/bin/ruby
ruby -v
# ruby 1.8.7 (2010-01-10 patchlevel 330) [i686-linux]
if [ $? != 0 ]; then exit 1; fi
which ruby

## opensslをインストール
cd $srcdir/$target/ext/openssl/
ruby extconf.rb
if [ $? != 0 ]; then exit 1; fi
make
if [ $? != 0 ]; then exit 1; fi
$SUDO make install
if [ $? != 0 ]; then exit 1; fi

## zlibをインストール
cd $srcdir/$target/ext/zlib/
ruby extconf.rb
if [ $? != 0 ]; then exit 1; fi
make
if [ $? != 0 ]; then exit 1; fi
$SUDO make install
if [ $? != 0 ]; then exit 1; fi
