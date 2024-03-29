
IMAGENAME := ghcr.io/bitnoize/ansible

.PHONY: help build rebuild push pull

.DEFAULT_GOAL := help

help:
	@echo "Makefile commands: build rebuild push pull"

#build: export BUILD_OPTS := ...
build: .build-8-bookworm

rebuild: export BUILD_OPTS := --pull --no-cache
rebuild: .build-8-bookworm

.build-8-bookworm:
	docker build $(BUILD_OPTS) \
		-t "$(IMAGENAME):8-bookworm" \
		-t "$(IMAGENAME):latest" \
		-f Dockerfile.bookworm \
		.

#push: export PUSH_OPTS := ...
push: .push-8-bookworm

.push-8-bookworm:
	docker push $(PUSH_OPTS) "$(IMAGENAME):8-bookworm"
	docker push $(PUSH_OPTS) "$(IMAGENAME):latest"

#pull: export PULL_OPTS := ...
pull: .pull-8-bookworm

.pull-8-bookworm:
	docker pull $(PULL_OPTS) "$(IMAGENAME):8-bookworm"
	docker pull $(PULL_OPTS) "$(IMAGENAME):latest"

