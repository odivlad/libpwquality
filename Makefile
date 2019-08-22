.PHONY: sources spec

PROJECT    ?= libpwquality
PACKAGE    := $(PROJECT)

VERSION     = $(shell git describe --tags --abbrev=0 | cut -d '-' -f2)
HEAD_SHA   := $(shell git rev-parse --short --verify HEAD)

spec: ## create spec file
	@git cat-file -p $(HEAD_SHA):$(PACKAGE).spec.in | sed -e 's,@PACKAGE_VERSION@,$(VERSION),g' > $(PACKAGE).spec

sources: spec
	@git archive --format=tar --prefix=$(PROJECT)-$(VERSION)/ $(HEAD_SHA) | \
	     bzip2 > $(PROJECT)-$(VERSION).tar.bz2
