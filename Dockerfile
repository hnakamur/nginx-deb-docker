# syntax=docker/dockerfile:1
ARG OS_TYPE=ubuntu
ARG OS_VERSION=22.04
FROM ${OS_TYPE}:${OS_VERSION}

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install tzdata apt-utils \
    gcc make \
    debhelper dpkg-dev quilt lsb-release libssl-dev libpcre3-dev zlib1g-dev \
    libexpat1-dev libxslt1-dev libgd-dev libgeoip-dev libmhash-dev libmaxminddb-dev \
    # libmodsecurity dependencies
    libyajl2 liblmdb0 libfuzzy2

ARG LUAJIT_DEB_VERSION
ARG LUAJIT_DEB_OS_ID
RUN mkdir -p /depends
RUN curl -sSL https://github.com/hnakamur/openresty-luajit-deb-docker/releases/download/${LUAJIT_DEB_VERSION}/dist-${LUAJIT_DEB_OS_ID}.tar.gz | tar zxf - -C /depends --strip-components=2
RUN dpkg -i /depends/*.deb

ARG MODSECURITY_DEB_VERSION
ARG MODSECURITY_DEB_OS_ID
RUN mkdir -p /depends
RUN curl -sSL https://github.com/hnakamur/modsecurity-deb-docker/releases/download/${MODSECURITY_DEB_VERSION}${MODSECURITY_DEB_OS_ID}/modsecurity-${MODSECURITY_DEB_VERSION}${MODSECURITY_DEB_OS_ID}-dist.tar.gz | tar zxf - -C /depends --strip-components=2
RUN ls -l /depends/libmodsecurity3_*.deb /depends/libmodsecurity-dev*.deb
RUN dpkg -i /depends/libmodsecurity3_*.deb
RUN dpkg -i /depends/libmodsecurity-dev*.deb

ARG SRC_DIR=/src
ARG BUILD_USER=build
RUN useradd -m -d ${SRC_DIR} -s /bin/bash ${BUILD_USER}

COPY --chown=${BUILD_USER}:${BUILD_USER} ./nginx/ /src/nginx/
COPY --chown=${BUILD_USER}:${BUILD_USER} ./modules/ /src/nginx/
USER ${BUILD_USER}
WORKDIR ${SRC_DIR}
ARG PKG_VERSION
RUN tar cf - nginx | xz > nginx_${PKG_VERSION}.orig.tar.xz

COPY --chown=build:build ./debian /src/nginx/debian/
WORKDIR ${SRC_DIR}/nginx
ARG PKG_REL_DISTRIB
RUN sed -i "s/DebRelDistrib/${PKG_REL_DISTRIB}/;s/UNRELEASED/$(lsb_release -cs)/" /src/nginx/debian/changelog
RUN dpkg-buildpackage -us -uc

USER root
