FROM ubuntu:15.10
RUN apt-get -q update && apt-get -qy install squid3
RUN sed -i "s/^#acl localnet/acl localnet/" /etc/squid3/squid.conf
RUN sed -i "s/^#http_access allow localnet/http_access allow localnet/" /etc/squid3/squid.conf
RUN echo 'http_port 3129 intercept' >> /etc/squid3/squid.conf && echo 'maximum_object_size 1024 MB' >> /etc/squid3/squid.conf && echo 'cache_dir ufs /var/cache/squid3 5000 16 256' >> /etc/squid3/squid.conf
RUN mkdir -p /var/cache/squid3
RUN chown -R proxy:proxy /var/cache/squid3
CMD squid3 -z && squid3 -N
