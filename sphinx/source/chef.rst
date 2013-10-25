Chef Tips
=========

cookbook作成
------------
::

    rake new_cookbook COOKBOOK=cookbook-name

Berkshelf
------------
::

    $ gem install berkshelf
    $ cat Berksfile
    site :opscode

    cookbook "cookbook-name"
    $ berks --path=vendor/cookbooks

