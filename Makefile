SHELL := /bin/bash
BUNDLE := bundle
YARN := yarn
BUNDLE_DIR := vendor/bundler
VENDOR_DIR = _src/vendor/
JEKYLL := $(BUNDLE) exec jekyll
PROJECT_DEPS := Gemfile package.json

# Staging Variables
BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
STAGING_COUNT := $(shell find ./ -name '_staging*' -print | wc -l)
PORT := $$(($(STAGING_COUNT)+4001))
DEST := _staging-$(BRANCH)-$(STAGING_COUNT)
URL := 127.0.0.1:$(PORT) $(BRANCH)-$(STAGING_COUNT)

all: serve

clean:
	rm -rf _site vendor node_modules .bundle .sass-cache

check:
	$(JEKYLL) doctor
	$(HTMLPROOF) --check-html \
		--http-status-ignore 999 \
		--internal-domains localhost:4000 \
		--assume-extension \
		_site

install: $(PROJECT_DEPS)
	$(BUNDLE) install --path $(BUNDLE_DIR) --jobs=4
	$(YARN) install

reinstall: clean install static

update: $(PROJECT_DEPS)
	$(BUNDLE) update
	$(YARN) upgrade

static:
	rm -rf $(VENDOR_DIR)
	mkdir -p $(VENDOR_DIR)
	cp node_modules/jquery/dist/jquery.min.* $(VENDOR_DIR)
	cp node_modules/popper.js/dist/umd/popper.min.* $(VENDOR_DIR)
	mkdir -p $(VENDOR_DIR)bootstrap
	cp node_modules/bootstrap/dist/js/bootstrap.js node_modules/bootstrap/dist/js/bootstrap.js.map  $(VENDOR_DIR)bootstrap/
	cp -r node_modules/bootstrap/scss $(VENDOR_DIR)bootstrap/_scss
	mkdir -p $(VENDOR_DIR)fontawesome
	cp -r node_modules/@fortawesome/fontawesome-free/js $(VENDOR_DIR)fontawesome/

build: install static
	$(JEKYLL) build

serve: install static
	JEKYLL_ENV=development $(JEKYLL) serve

stage: install static
	bundle exec jekyll serve --no-watch --destination $(DEST) --port $(PORT) & forward $(URL)
