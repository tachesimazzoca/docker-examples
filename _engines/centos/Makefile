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
	@bundle install --path vendor/bundle

.PHONY: test
test:
	@bundle exec rake spec:vbox
