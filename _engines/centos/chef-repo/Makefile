.PHONY: development
development:
	@if [ ! -f "nodes/dev-docker-engine.json" ]; then \
  echo "No development nodes are found. Run scripts/preprare-development.sh <host>"; \
fi
	@./knife zero converge 'chef_environment:development'

.PHONY: chkconfig
chkconfig:
	@for f in `find cookbooks -name '*.rb'`; do ruby -c $$f > /dev/null; done
	@for f in `find cookbooks -name '*.erb'`; do erb -x $$f | ruby -c > /dev/null; done
