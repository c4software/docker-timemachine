VERSION=$(shell cat VERSION)

all: build

build:
	docker build -t mtneug/timemachine -t timemachine:${VERSION} .
.PHONY: build

clean:
	-docker rmi mtneug/timemachine timemachine:${VERSION}
.PHONY: clean

lint:
	shellcheck *.sh
.PHONY: lint
