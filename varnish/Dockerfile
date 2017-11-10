# Author: Cuong Tran
#
# Build: docker build -t cuongtransc/vanish:0.1 .
# Run: docker run -d -p 8080:8080 --name app-run cuongtransc/vanish:0.1
#

FROM debian:jessie

MAINTAINER Cuong Tran "cuongtransc@gmail.com"

# using apt-cacher-ng proxy for caching deb package
RUN echo 'Acquire::http::Proxy "http://172.17.0.1:3142/";' > /etc/apt/apt.conf.d/01proxy

ENV REFRESHED_AT 2016-08-24

RUN apt-get update -qq

RUN apt-get install -y apt-transport-https \
    && apt-get install -y curl \
    && curl https://repo.varnish-cache.org/GPG-key.txt | apt-key add - \
    && echo "deb https://repo.varnish-cache.org/debian/ jessie varnish-4.0" >> /etc/apt/sources.list.d/varnish-cache.list \
    && apt-get update \
    && apt-get install -y varnish

COPY docker-entrypoint.sh /docker-entrypoint.sh
# COPY default.tmpl /etc/varnish/default.tmpl
COPY default_dev.tmpl /etc/varnish/default.tmpl

ENV CACHE_SIZE=128m

EXPOSE 80

# STOPSIGNAL SIGINT

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["vanishd"]
