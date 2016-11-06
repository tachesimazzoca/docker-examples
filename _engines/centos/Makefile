.PHONY: all
all:
	@cp skel/* .

.PHONY: clean
clean:
	@rm -rf chef/ssh_config
	@rm -rf .vagrant
	@rm -rf Vagrantfile bootstrap.sh
	@rm -rf .bundle vendor

.PHONY: gems
gems:
	@if [ -d vendor ]; then bundle update; else bundle install --path vendor/bundle; fi

.PHONY: chef
chef:
	@vagrant ssh-config > chef/ssh_config
	@chef/bin/knife-solo prepare
	@chef/bin/knife-solo cook
