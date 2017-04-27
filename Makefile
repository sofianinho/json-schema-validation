.PHONY: build image run 

export GOPATH:=$(shell pwd)
IMAGE_NAME = jsonvalidator
IMAGE_TAG = latest

HELP_FUN = \
	%help; \
	while(<>) { push @{$$help{$$2 // 'options'}}, [$$1, $$3] if /^(\w+)\s*:.*\#\#(?:@(\w+))?\s(.*)$$/ }; \
  	print "usage: make [target]\n\n"; \
	for (keys %help) { \
  	print "$$_:\n"; $$sep = " " x (20 - length $$_->[0]); \
  	print "  $$_->[0]$$sep$$_->[1]\n" for @{$$help{$$_}}; \
  	print "\n"; }     

help:           ## Show this help.
	@perl -e '$(HELP_FUN)' $(MAKEFILE_LIST)

build: ##@go build the executable (you must have the go compiler in your system)
	@echo building your executable
	go get -v
	CGO_ENABLED=0 go build

image: build ##@docker build the docker image locally
	@echo building your docker image
	docker build --tag=$(IMAGE_NAME):$(IMAGE_TAG) .

run: ##@docker run the example given in the example directory
	@echo running the correct example
	docker run -t --rm -v $(PWD)/example:/data $(IMAGE_NAME):$(IMAGE_TAG) --json-path /data/test.json --schema-path /data/schema.json
	@echo running the wrong example
	docker run -t --rm -v $(PWD)/example:/data $(IMAGE_NAME):$(IMAGE_TAG) --json-path /data/wrong.json --schema-path /data/schema.json
