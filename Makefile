SHELL=/bin/bash
GIT_HASH=`git rev-parse --short HEAD`
BUILD_DATE=`date +%FT%T%z`

BIN=bin/micro.app
SRC=./cmd/micro

LDFLAGS=-w -s -X main.GitHash=${GIT_HASH} -X main.BuildDate=${BUILD_DATE}

export CGO_ENABLED=0
export GOOS=linux
export GOARCH=amd64

.PHONY: clean build

vet:
	go vet ./...

lint: vet
	golangci-lint run

build: vet
	go build -ldflags "${LDFLAGS}" -o "${BIN}" "${SRC}"

docker-scratch: lint
	docker build \
		--no-cache=true \
		--build-arg BUILD_REV="${GIT_HASH}" \
		--build-arg BUILD_DATE="${BUILD_DATE}" \
		-t s0rg/microapp-scratch:latest \
		-f Dockerfile.scratch .

docker-distroless: lint
	docker build \
		--no-cache=true \
		--build-arg BUILD_REV=${GIT_HASH} \
		--build-arg BUILD_DATE=${BUILD_DATE} \
		-t s0rg/microapp-distroless:latest \
		-f Dockerfile.distroless .

clean:
	[ -f "${BIN}" ] && rm "${BIN}"
