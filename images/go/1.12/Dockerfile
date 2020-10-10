FROM golang:1.12-alpine

RUN apk add git

VOLUME ["/data", "$GOPATH/pkg/mod"]

ENTRYPOINT ["go"]

