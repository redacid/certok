FROM alpine
MAINTAINER Jessica Frazelle <jess@docker.com>

ENV PATH /go/bin:/usr/local/go/bin:$PATH
ENV GOPATH /go
ENV GO15VENDOREXPERIMENT 1

RUN	apk update && apk add \
	ca-certificates \
	&& rm -rf /var/cache/apk/*

COPY . /go/src/github.com/jfrazelle/certok

RUN buildDeps=' \
		go \
		git \
		gcc \
		libc-dev \
		libgcc \
	' \
	set -x \
	&& apk update \
	&& apk add $buildDeps \
	&& cd /go/src/github.com/jfrazelle/certok \
	&& go build -o /usr/bin/certok . \
	&& apk del $buildDeps \
	&& rm -rf /var/cache/apk/* \
	&& rm -rf /go \
	&& echo "Build complete."


ENTRYPOINT [ "certok" ]
