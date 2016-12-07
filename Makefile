NAME:=node_ci
NOCACHE?=false
REGISTRY?=jcmuller
GIT_COMMIT?=$(shell git rev-parse HEAD)
IMAGE_NAME=$(REGISTRY)/$(NAME)
VERSIONED_IMAGE=$(IMAGE_NAME):$(GIT_COMMIT)
LATEST_IMAGE=$(IMAGE_NAME):latest

all: push

.PHONY: build
build: Dockerfile
	docker build \
		--no-cache=$(NOCACHE) \
			-t $(IMAGE_NAME) \
			.

.PHONY: tag
tag: build
	docker tag $(IMAGE_NAME) $(LATEST_IMAGE)
	docker tag $(IMAGE_NAME) $(VERSIONED_IMAGE)

.PHONY: push
push: tag
	docker push $(VERSIONED_IMAGE)
	docker push $(LATEST_IMAGE)
