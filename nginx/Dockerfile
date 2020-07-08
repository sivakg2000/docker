FROM ubuntu:14.04

MAINTAINER sivakg2000

RUN apt-get update
RUN apt-get install -y nginx

ADD index.html /usr/share/nginx/html/index.html

ENTRYPOINT [ "/usr/sbin/nginx","-g","daemon off;" ]

EXPOSE 80