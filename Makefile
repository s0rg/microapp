GIT_HASH=`git rev-parse --short HEAD`
BUILD_DATE=`date +%FT%T%z`

BIN=bin/micro.app
SRC=./cmd/micro

LDFLAGS=-w -s -X main.GitHash=${GIT_HASH} -X main.BuildDate=${BUILD_DATE}

export CGO_ENABLED=0
export GOOS=linux
export GOARCH=amd64

.PHONY: clean build

build: vet
	go build -ldflags "${LDFLAGS}" -o "${BIN}" "${SRC}"

docker: vet
	docker build -t s0rg/microapp:latest --no-cache=true .

vet:
	go vet ./...

lint: vet
	golangci-lint run

clean:
	[ -f "${BIN}" ] && rm "${BIN}"
