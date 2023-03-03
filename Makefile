
IMAGENAME := ghcr.io/bitnoize/ansible

.PHONY: help build rebuild push pull

.DEFAULT_GOAL := help

help:
	@echo "Makefile commands: build rebuild push pull"

#build: export BUILD_OPTS := ...
build: .build-7.3.0-bullseye

rebuild: export BUILD_OPTS := --pull --no-cache
rebuild: .build-7.3.0-bullseye

.build-7.3.0-bullseye:
	docker build $(BUILD_OPTS) \
		--build-arg ANSIBLE_VERSION=7.3.0 \
		-t "$(IMAGENAME):7.3.0-bullseye" \
		-t "$(IMAGENAME):7-bullseye" \
		-t "$(IMAGENAME):latest" \
		-f Dockerfile.bullseye \
		.

#push: export PUSH_OPTS := ...
push: .push-7.3.0-bullseye

.push-7.3.0-bullseye:
	docker push $(PUSH_OPTS) "$(IMAGENAME):7.3.0-bullseye"
	docker push $(PUSH_OPTS) "$(IMAGENAME):7-bullseye"
	docker push $(PUSH_OPTS) "$(IMAGENAME):latest"

#pull: export PULL_OPTS := ...
pull: .pull-7.3.0-bullseye

.pull-7.3.0-bullseye:
	docker pull $(PULL_OPTS) "$(IMAGENAME):7.3.0-bullseye"
	docker pull $(PULL_OPTS) "$(IMAGENAME):7-bullseye"
	docker pull $(PULL_OPTS) "$(IMAGENAME):latest"

