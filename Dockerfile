# VERSION 0.1
# AUTHOR:         zhengxiaochuan <zhengxiaochuan-3@163.com>
# DESCRIPTION:    ngx_openresty
# TO_BUILD:       docker build -rm -t ngx_openresty .
# TO_RUN:         docker run -p hostport:80 -v /export/log/:/export/log/ -v /export/data:/export/data/ -v /export/conf/:/export/conf/ -d ngx_openresty

# from centos
FROM index.alauda.cn/zhengxiaochuan/centos_base:latest 

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
