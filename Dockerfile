FROM golang:latest as go-builder
MAINTAINER Valentin Kuznetsov vkuznet@gmail.com

# DAS tag to use
ENV TAG=00.00.01

# build procedure
ENV WDIR=/data
WORKDIR $WDIR
RUN mkdir -p /data/gopath && mkdir /build
ENV GOPATH=/data/gopath
ARG CGO_ENABLED=0
RUN git clone https://github.com/vkuznet/k8snodemon && \
    git checkout tags/$TAG -b build && make && cp k8snodemon /build

FROM alpine
RUN mkdir -p /data
COPY --from=go-builder /build/k8snodemon /data/
