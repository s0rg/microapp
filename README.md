# microapp
minimal dockerized application example with 2-staged dockerfiles (scratch and distroless versions)

# workflow

* build stand-alone binary: `make build`
* build docker with `scratch`-base image: `make docker-scratch`
* build docker with `distroless`-base image: `make docker-distroless`

# environment config

`ADDR` - address for the server to listen on (default is 0.0.0.0:8080)

# usage

`docker run s0rg/microapp-scratch` or `docker run s0rg/microapp-distroless`

application serves two endpoints:

* `/` - returns string with application host and user names
* `/health` - returns HTTP 204 if app serves well.

it can be used in docker-compose environments as load-balancing
testing utility.

# license

MIT
