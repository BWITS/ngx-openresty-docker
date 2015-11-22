# VERSION 0.1
# AUTHOR:         zhengxiaochuan <zhengxiaochuan-3@163.com>
# DESCRIPTION:    Image with nginx
# TO_BUILD:       docker build -rm -t ngx_openresty .
# TO_RUN:         docker run --name some-nginx -p hostport:nginxport -v /some/contentpath:/some/nginxfilepath:ro -d nginx

# Latest Ubuntu LTS
from index.alauda.cn/zhengxiaochuan/centos_base:latest 

# Add source code
add . /ngx_openresty

WORKDIR /ngx_openresty

# Compile source code
run /usr/bin/env perl configure
run chmod +x build/install
run make
run make install

# Run nginx
ENTRYPOINT ["/usr/local/openresty/nginx/sbin/nginx -t -c /usr/local/openresty/nginx/conf/nginx.conf"]
# export 80 port
expose 80




