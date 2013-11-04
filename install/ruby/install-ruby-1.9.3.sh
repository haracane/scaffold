sudo yum -y install gcc gcc-c++ openssl-devel zlib-devel \
  libxml2-devel libxslt-devel libyaml-devel readline-devel \
  ncurses-devel gdbm-devel tcl-devel db4-devel libffi-devel
if [ $? != 0 ]; then exit 1; fi

srcdir=~/src
if [ ! -d $srcdir ]; then mkdir -p $srcdir; fi
cd $srcdir

cd ~/src
target=ruby-1.9.3-p385
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
sudo make install
if [ $? != 0 ]; then exit 1; fi

ruby -v
if [ $? != 0 ]; then exit 1; fi
which ruby

exit 0
