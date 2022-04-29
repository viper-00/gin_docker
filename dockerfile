# syntax=docker/dockerfile:1

FROM golang:alpine

# Working directory in docker
WORKDIR /gin_docker

# For well-known reasons, some packages will have download timeouts. The proxy service of go module is also used in docker
ENV GO111MODULE=on
ENV GOPROXY="https://goproxy.io"

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

RUN go build -0 /gin_docker

EXPOSE 8080

# This is consistent with the compiled file name
CMD [ "./gin_docker" ]

# # Specify the file name after compilation. You can use the default file name without setting. The last step is to execute the file name
# RUN go mod download
# RUN go build -o /gin_docker
# EXPOSE 8080