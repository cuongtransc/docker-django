# Author: Cuong Tran
#
# Build: docker build -t tranhuucuong91/nginx:0.1 .
# Run: docker run -d -p 80:80 --name mesos-admin-run tranhuucuong91/nginx:0.1
#

FROM ubuntu:16.04
MAINTAINER Cuong Tran "tranhuucuong91@gmail.com"

# using apt-cacher-ng proxy for caching deb package
RUN echo 'Acquire::http::Proxy "http://172.17.0.1:3142/";' > /etc/apt/apt.conf.d/01proxy

ENV REFRESHED_AT 2016-08-24

RUN apt-get update -qq

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nginx

# clear apt-cacher-ng proxy
#RUN rm -f /etc/apt/apt.conf.d/01proxy

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

RUN rm /etc/nginx/sites-enabled/default
COPY sites-enabled/ /etc/nginx/sites-enabled

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
