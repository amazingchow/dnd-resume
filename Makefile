VERSION       := v1.0.0
GIT_HASH      := $(shell git rev-parse --short HEAD)
IMAGE_VERSION := ${VERSION}-${GIT_HASH}
CURR_DIR      := $(shell pwd)

.PHONY: help
help: ### Display this help screen.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: run_site_locally
run_site_locally: ### Run the site locally.
	@(pnpm run dev)

.PHONY: build_site
build_site: ### Build the site.
	@(pnpm run build)

.PHONY: run_site
run_site: build_site ### Run the site in a daemon process.
	@(pm2 start dist/index.js --name dnd-resume)

.PHONY: re_run_site
re_run_site: build_site ### Re-run the site.
	@(pm2 restart dnd-resume)

.PHONY: stop_site
stop_site: ### Stop the site.
	@(pm2 stop dnd-resume)