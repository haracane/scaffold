cwd=$(cd $(dirname $0)/..; pwd)

cd $cwd

role=$1

solorb_file=$(mktemp /tmp/chef-solo-recipe.sh.XXXXXX)

sh ./script/print-solorb.sh > $solorb_file
if [ $? != 0 ]; then exit 1; fi

chef-solo -c $solorb_file -o role[$role]
if [ $? != 0 ]; then exit 1; fi

rm $solorb_file

