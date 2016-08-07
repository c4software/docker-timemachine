VERSION=$(shell cat VERSION)

all: build

build:
	docker build -t mtneug/timemachine -t mtneug/timemachine:${VERSION} .
.PHONY: build

clean:
	-docker rmi mtneug/timemachine mtneug/timemachine:${VERSION}
.PHONY: clean

lint:
	shellcheck *.sh
.PHONY: lint
