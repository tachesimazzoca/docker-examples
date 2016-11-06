#!/usr/bin/env bash

# Reset network.service
nmcli connection reload
systemctl restart network.service

# Install Chef omnibus package
if ! which chef-client > /dev/null 2>&1;
then
  curl -L https://www.chef.io/chef/install.sh | sudo bash -s -- -v 12.15.19
fi

# Run chef-client -z
rm -rf /tmp/chef-repo && \
  cp -R /vagrant/chef-repo /tmp/. && \
  cd /tmp/chef-repo && make vbox
