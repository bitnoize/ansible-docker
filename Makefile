
IMAGENAME := bitnoize/ansible

.PHONY: help build rebuild

.DEFAULT_GOAL := help

help:
	@echo "Makefile commands: build rebuild"

#build: export BUILD_OPTS := ...
#build: export PUSH_OPTS := ...
build: .build-6.2.0-bullseye .push-6.2.0-bullseye

rebuild: export BUILD_OPTS := --pull --no-cache
#rebuild: export PUSH_OPTS := ...
rebuild: .build-6.2.0-bullseye .push-6.2.0-bullseye

.build-6.2.0-bullseye:
	docker build $(BUILD_OPTS) \
		--build-arg ANSIBLE_VERSION=6.2.0 \
		-t "$(IMAGENAME):6.2.0-bullseye" \
		-t "$(IMAGENAME):6-bullseye" \
		-t "$(IMAGENAME):latest" \
		-f Dockerfile.bullseye \
		.

.push-6.2.0-bullseye:
	docker push $(PUSH_OPTS) "$(IMAGENAME):6.2.0-bullseye"
	docker push $(PUSH_OPTS) "$(IMAGENAME):6-bullseye"
	docker push $(PUSH_OPTS) "$(IMAGENAME):latest"

