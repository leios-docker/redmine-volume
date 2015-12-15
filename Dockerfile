# Pull base image.
FROM ubuntu:14.04

RUN locale-gen ko_KR.UTF-8
RUN update-locale LANG=ko_KR.UTF-8
RUN dpkg-reconfigure locales

ENV LANG ko_KR.UTF-8
ENV LC_ALL ko_KR.UTF-8

COPY files/database.yml /redmine/config/database.yml

RUN \
    sed -ri 's/\/archive\.ubuntu\.com/\/kr\.archive\.ubuntu\.com/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y \
        curl \
        libmysqlclient-dev \
        libmagickwand-dev \
        imagemagick \
        ruby1.9.3 \
        git-core && \
    apt-get build-dep -y redmine && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /redmine && \
    curl -L --progress http://www.redmine.org/releases/redmine-3.0.1.tar.gz | tar xz -C /redmine/ --strip-components=1

# Define mountable directories.
VOLUME ["/redmine/config", "/redmine/files", "/redmine/plugins", "/redmine/repo", "/redmine/log"]

# Define working directory.
WORKDIR /redmine
