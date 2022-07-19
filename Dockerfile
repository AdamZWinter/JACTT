FROM debian:buster
MAINTAINER Adam Z Winter

# Steps done in one RUN layer:
# - Install packages
RUN apt-get update && \
    apt-get -y install openssh-server

COPY files/entrypoint /

EXPOSE 22

ENTRYPOINT ["/entrypoint"]
