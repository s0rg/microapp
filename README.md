# microapp
minimal dockerized application

# workflow

* build binary
`make build`

* build docker
`make docker`

# environment

`ADDR` - address for the server to listen on

# usage

application serves two endpoints:

`/` - returns string with application host and user names
`/health` - always returns HTTP 204

it can be used in docker-compose environments as load-balancing
testing utility.

health-endpoint is (mostly) for consul health-checks,
for service-discovery.

# license

MIT
