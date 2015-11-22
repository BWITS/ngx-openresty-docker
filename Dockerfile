# VERSION 0.1
# AUTHOR:         zhengxiaochuan <zhengxiaochuan-3@163.com>
# DESCRIPTION:    Image with nginx
# TO_BUILD:       docker build -rm -t ngx_openresty .
# TO_RUN:         docker run --name some-nginx -p hostport:nginxport -v /some/contentpath:/some/nginxfilepath:ro -d nginx

# Latest Ubuntu LTS
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
ENTRYPOINT ["/usr/local/openresty/nginx/sbin/nginx -t -c /usr/local/openresty/nginx/conf/nginx.conf"]

# export 80 port
EXPOSE 80




