Example project to get the hang of the Go language, Docker containers, continuous integration with CircleCI.

This is built on Ubuntu Xenial (16.04). On Windows/Mac some tweaks probably needed.

Build status: [![CircleCI](https://circleci.com/gh/halla/golang-docker-circleci-example/tree/master.svg?style=svg)](https://circleci.com/gh/halla/golang-docker-circleci-example/tree/master)

## Core Todo

* Docker hello world  
* Hello http server  
* Unit test case  
* Development workflow with code reload/compile  
* Make a HTTP-request  
* Parse JSON  
* CircleCI integration  
* Production deployment  
* Contiuous deployment  

## More Todo
* Use a goroutine  
* Use a channel  
* Use an HTML template  
* Serve static files
* docker-compose.yml



## Usage

### Development

Assuming you have docker installed, clone this repo, cd to the project directory, build and run:

* $ docker build -t hello-golang .
* $ docker run --volume=$PWD:/go/src/app -p 8080:3000 --rm --name my-running-app hello-golang

You should see "Starting server..." in the console, and "Hello world" in your browser if you navigate to localhost:8080

> build -t tags the container with the given name
> --volume mounts the current directory to the docker container for code reloading
> -p binds your host port to docker port
> --rm removes the container after exit
> --name assigns a name

If you modify the source code, you should see the changes when refreshing your browser window.

### Deployment

To deploy the project using the image in Docker Hub registry

* install Docker on your server
* docker pull ahalla/golang-docker-circleci-example
* docker run -d -p 8080:3000 --rm --name golang-docker-circleci-example ahalla/golang-docker-circleci-example

This will run the container as a background job, listening to the OS port 8080. The container will be removed automatically when killed.

### Contiuous deployment

To automatically update the running application, you can do something along the lines of:

```bash
#/bin/bash
echo "Pulling the latest version from registry"
docker pull ahalla/golang-docker-circleci-example
echo "Killing the running container"
docker kill golang-docker-circleci-example
echo "Preparing to run.."
docker run -d -p 8080:3000 --rm --name golang-docker-circleci-example ahalla/golang-docker-circleci-example
```

Here we give the container a name so we can kill it later. This script can be either triggered from the CI or run
in cron for periodical updates (you should probably add a check whether a new version was actually pulled or not).

This is a naive solution, but probably enough to start with.


## Technology links

 * The Go Programming Language https://golang.org/
 * Docker https://www.docker.com/
 * CircleCI https://circleci.com/
 * golang docker image https://hub.docker.com/_/golang/
 * gin for code reloading https://github.com/codegangsta/gin

## Tutorials

* Install Docker on Ubuntu 16.04 https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04
* Development with Go and Docker https://medium.com/developers-writing/docker-powered-development-environment-for-your-go-app-6185d043ea35

## Issue knowledge
1. Fix issue related to Golang version: strings.Builder type undefined  
##### Problem  
```
$ docker build -t hello-golang .

=> Error:
 > [3/7] RUN go get github.com/codegangsta/gin:
#7 10.17 # github.com/urfave/cli
#7 10.17 src/github.com/urfave/cli/fish.go:74:18: undefined: strings.Builder
#7 10.17 src/github.com/urfave/cli/fish.go:123:18: undefined: strings.Builder
#7 10.17 src/github.com/urfave/cli/fish.go:160:45: undefined: strings.Builder

```
##### Solution
```
Because golang version is old, Dockerfile define that:
$ FROM golang:1.9-alpine
To fix it, change golang to new version:
$ FROM golang:1.15-alpine

```
##### Note:
alpine is a feature to caching memory.  
To use it, it is used by command in Dockerfile
``` 
RUN apk add --no-cache git

```
##### Refer:  
      https://stackoverflow.com/questions/48978414/golang-strings-builder-type-undefined  

2. Fix issue related to GIN library. 
##### Problem  
```
$ docker build -t hello-golang .

=> [1/7] FROM docker.io/library/golang:1.15-alpine@sha256:b58c367d52e46cdedc25ec9cd74cadb14ad65e8db75b25e5ec117c  0.0s
=> CACHED [2/7] RUN apk add --no-cache git                                                                        0.0s
=> ERROR [3/7] RUN go get github.com/codegangsta/gin                                                             13.0s
------
 > [3/7] RUN go get github.com/codegangsta/gin:
#6 12.99 # github.com/codegangsta/gin
#6 12.99 src/github.com/codegangsta/gin/main.go:40:13: cannot use MainAction (type func(*cli.Context)) as type cli.ActionFunc in assignment
#6 12.99 src/github.com/codegangsta/gin/main.go:42:17: cannot use cli.StringFlag literal (type cli.StringFlag) as type cli.Flag in slice literal:
#6 12.99        cli.StringFlag does not implement cli.Flag (Apply method has pointer receiver)

```
##### Solution
Because we are using codegangta library from github: https://github.com/codegangsta/gin
It always changing content of source code, unfortunately, it happened this error.  
Therefore, I must following issue on that repository, and we find this issue following info below
```
Before: 
# Gin for code reloading
RUN go get github.com/codegangsta/gin

After:
# Gin for code reloading
RUN go get github.com/kisielk/errcheck \
    && go get golang.org/x/lint/golint \
    && go get github.com/stripe/safesql \
    && GO111MODULE=on go get github.com/gobuffalo/buffalo/buffalo@v0.15.1

```
##### Refer:  
    https://github.com/codegangsta/gin/issues/169

3. Fix issue related to run command on Docker virtual machine.
##### Problem  
```
$ docker build -t hello-golang .

=> ERROR [6/7] RUN go-wrapper download # "go get -d -v ./..."
------
 > [6/7] RUN go-wrapper download # "go get -d -v ./...":
#11 0.328 /bin/sh: go-wrapper: not found
------
executor failed running [/bin/sh -c go-wrapper download # "go get -d -v ./..."]: exit code: 127

```
##### Solution
```
Before: 
RUN go-wrapper download # "go get -d -v ./..."
RUN go-wrapper install # "go install -v ./..."

After:
RUN go get -d -v ./...
RUN go install -v ./...

```
##### Refer:  
    https://github.com/whalebrew/whalebrew/commit/2495345eadd7b1860a3557c81f203619d9b84ea8