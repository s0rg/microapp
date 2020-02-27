BIN=bin/micro.app
SRC=./cmd/micro
LDFLAGS=-w -s

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
