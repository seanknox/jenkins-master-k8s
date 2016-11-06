default: docker_build

DOCKER_IMAGE ?= quay.io/seanquay/jenkins-master-k8s
BUILD_NUMBER ?= `git rev-parse --short HEAD`

.PHONY: docker_build
docker_build:
	@docker build -t $(DOCKER_IMAGE):$(BUILD_NUMBER) .

.PHONY: docker_push
docker_push:
	# Push to image repository
	docker tag $(DOCKER_IMAGE):$(BUILD_NUMBER) $(DOCKER_IMAGE):latest
	docker push $(DOCKER_IMAGE):$(BUILD_NUMBER)
	docker push $(DOCKER_IMAGE):latest

.PHONY: all
all: docker_build docker_push
