#!/bin/sh

set -e

if [ ! -d "/opt/chef" ];
then
  curl -L https://www.chef.io/chef/install.sh | sudo bash -s -- -v 12.19.36
fi

if [ -f "/vagrant/chef-repo/localhost.json" ];
then
  cd /vagrant/chef-repo
  chef-client -z -N localhost -j localhost.json
fi
