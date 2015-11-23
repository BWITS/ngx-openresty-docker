FROM alpine:3.2

# VERSION 0.1
# DESCRIPTION:    ngx_openresty
# TO_BUILD:       docker build -t ngx_openresty .
# TO_RUN:         docker run -p hostport:80 -v /export/log/:/export/log/ -v /export/data:/export/data/ -v /export/conf/:/export/conf/ -d ngx_openresty

RUN apk update && apk add perl
RUN apk add alpine-sdk
RUN apk add pcre-dev
RUN apk add openssl-dev bash

# Add source code
ADD . /ngx_openresty

WORKDIR /ngx_openresty

# Compile source code
RUN /usr/bin/env perl configure
RUN chmod +x build/install
RUN make
RUN make install

# Run nginx
ENTRYPOINT /usr/local/openresty/nginx/sbin/nginx -c /usr/local/openresty/nginx/conf/nginx.conf && /bin/bash && sleep 9999d

# export 80 port
EXPOSE 80
# share /export/
VOLUME ["/export/log/"]
VOLUME ["/export/data/"]
VOLUME ["/export/conf/"]
