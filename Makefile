NAME:=node_ci
NOCACHE?=false
REGISTRY?=jcmuller
GIT_COMMIT?=$(shell git rev-parse HEAD)
IMAGE_NAME=$(REGISTRY)/$(NAME)
VERSIONED_IMAGE_NAME=$(IMAGE_NAME):$(GIT_COMMIT)

all: push

.PHONY: build
build: Dockerfile
	docker build \
		--no-cache=$(NOCACHE) \
			-t $(IMAGE_NAME) \
			.

.PHONY: tag
tag: build
	docker tag $(IMAGE_NAME) $(IMAGE_NAME):latest
	docker tag $(IMAGE_NAME) $(VERSIONED_IMAGE_NAME)

.PHONY: push
push: tag
	docker push $(VERSIONED_IMAGE_NAME)
