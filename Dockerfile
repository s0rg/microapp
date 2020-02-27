FROM golang:1.14-alpine AS builder

RUN apk add --update --no-cache make git ca-certificates tzdata \
 && adduser -D -H -g "" -s "" app

ADD . /go/src/github/s0rg/microapp
WORKDIR /go/src/github/s0rg/microapp

RUN make build

FROM scratch

ENV ADDR 0.0.0.0:8080

COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group
COPY --from=builder /go/src/github/s0rg/microapp/bin/micro.app /micro.app

USER app:app

ENTRYPOINT ["/micro.app"]
