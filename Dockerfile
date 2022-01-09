# consider using alpine-version in production, it's a lightweight distro
FROM golang:1.15-alpine

# since we're on alpine, we need to install what we need
RUN apk add --no-cache git

# Gin for code reloading
RUN go get github.com/kisielk/errcheck \
    && go get golang.org/x/lint/golint \
    && go get github.com/stripe/safesql \
    && GO111MODULE=on go get github.com/gobuffalo/buffalo/buffalo@v0.15.1
    
# /go/ is GOPATH, src is by convention, app is the executable name
WORKDIR /go/src/app
COPY . .

RUN go get -d -v ./...
RUN go install -v ./...

# Gin assumes PORT environment var is set
ENV PORT 8080

CMD ["gin", "run"]

# Gin not needed in production
# CMD ["go-wrapper", "run"] # ["app"]
