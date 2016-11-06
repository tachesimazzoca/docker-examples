.PHONY: all
all:
	@cp skel/* .

.PHONY: clean
clean:
	@rm -rf .vagrant
	@rm -rf Vagrantfile
	@rm -rf .bundle vendor

.PHONY: gems
gems:
	@if [ -d vendor ]; then bundle update; else bundle install --path vendor/bundle; fi

.PHONY: test
test:
	@bundle exec rake spec:vbox
