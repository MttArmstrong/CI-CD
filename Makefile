PROD_IMAGE=us-rse-ci-cd-course
DEV_IMAGE=$(PROD_IMAGE)-dev
SOURCE_DIR=/pages/INTERSECT-training/CI-CD

build-development:
	@docker build --no-cache -t $(DEV_IMAGE) --target builder .

run-development:
	@docker run \
		--rm \
		-v ${PWD}:$(SOURCE_DIR) \
		--user $(id -u):$(id -g) \
		--network host \
		-e PAGES_REPO_NWO=INTERSECT-training/CI-CD \
		$(DEV_IMAGE)

run-development-interactively:
	@docker run \
		--rm \
		-it \
		-w ${SOURCE_DIR} \
		-v ${PWD}:$(SOURCE_DIR) \
		--user $(id -u):$(id -g) \
		--network host \
		-e PAGES_REPO_NWO=INTERSECT-training/CI-CD \
		$(DEV_IMAGE) \
		/bin/bash

production:
	@docker build \
		--no-cache \
		--progress plain \
		--build-arg  PAGES_REPO_NWO=INTERSECT-training/CI-CD \
		-t $(PROD_IMAGE) .
	@echo -e "\nSite running on http://localhost:8080/index.html ...\n"
	@docker run -p 8080:80 $(PROD_IMAGE) 

