FROM alpine:3.2

# VERSION 0.1
# DESCRIPTION:    ngx_openresty
# TO_BUILD:       docker build -t ngx_openresty .
# TO_RUN:         docker run -p hostport:80 -v /export/log/:/export/log/ -v /export/data:/export/data/ -v /export/conf/:/export/conf/ -d ngx_openresty

# Add source code
# Compile source code
RUN apk update && apk add perl alpine-sdk pcre-dev openssl-dev bash && \
    git clone https://github.com/BWITS/ngx-openresty-docker.git /ngx-openresty && \
    cd /ngx-openresty && \
    /usr/bin/env perl configure && \
    chmod +x build/install && \
    make && \
    make install && \
    apk del alpine-sdk perl pcre-dev && \
    apk add libpcrecpp libpcre16 libpcre32 openssl libssl1.0 pcre libgcc libstdc++ && \
    rm -rf /var/cache/apk/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /ngx-openresty

# export 80 port
EXPOSE 80

# share /export/
VOLUME ["/export/log/"]
VOLUME ["/export/data/"]
VOLUME ["/export/conf/"]

# Run nginx
ENTRYPOINT /usr/local/openresty/nginx/sbin/nginx -c /usr/local/openresty/nginx/conf/nginx.conf && /bin/bash && sleep 9999d
