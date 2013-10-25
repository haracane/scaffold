cwd=$(cd $(dirname $0)/..;pwd)

cd $cwd

echo "file_cache_path '/tmp/chef-solo'
cookbook_path ['$cwd/chef-repo/site-cookbooks', '$cwd/chef-repo/cookbooks', '$cwd/chef-repo/vendor/cookbooks']
role_path '$cwd/chef-repo/roles'"
