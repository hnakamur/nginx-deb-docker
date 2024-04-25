# syntax=docker/dockerfile:1
ARG OS_TYPE=ubuntu
ARG OS_VERSION=22.04
FROM ${OS_TYPE}:${OS_VERSION}

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install tzdata apt-utils \
    gcc make \
    debhelper dpkg-dev quilt lsb-release libssl-dev libpcre3-dev zlib1g-dev \
    libexpat1-dev libxslt1-dev libgd-dev libgeoip-dev libmhash-dev libmaxminddb-dev \
    libperl-dev \
    # libmodsecurity dependencies
    libyajl2 liblmdb0 libfuzzy2 \
    # for nginx-tests
    sudo \
    ffmpeg \
    memcached \
    softhsm2 \
    libcache-memcached-fast-perl \
    libcache-memcached-perl \
    libcryptx-perl \
    libfcgi-perl \
    libgd-perl \
    libio-socket-ssl-perl \
    libengine-pkcs11-openssl \
    opensc \
    uwsgi \
    uwsgi-plugin-python3

# create symbolic links for nginx-tests
RUN mkdir -p /usr/local/lib/engines
RUN ln -s /usr/lib/x86_64-linux-gnu/engines-3/pkcs11.so /usr/local/lib/engines/pkcs11.so
RUN mkdir -p /usr/local/lib/softhsm
RUN ln -s /usr/lib/softhsm/libsofthsm2.so /usr/local/lib/softhsm/libsofthsm2.so

ARG LUAJIT_DEB_VERSION
ARG LUAJIT_DEB_OS_ID
RUN mkdir -p /depends
RUN curl -sSL https://github.com/hnakamur/openresty-luajit-deb-docker/releases/download/${LUAJIT_DEB_VERSION}${LUAJIT_DEB_OS_ID}/openresty-luajit-${LUAJIT_DEB_VERSION}${LUAJIT_DEB_OS_ID}.tar.gz | tar zxf - -C /depends --strip-components=2
RUN dpkg -i /depends/*.deb

ARG SRC_DIR=/src
ARG BUILD_USER=nginx
RUN adduser --system --group ${BUILD_USER}

COPY --chown=${BUILD_USER}:${BUILD_USER} ./nginx/ ${SRC_DIR}/nginx/
COPY --chown=${BUILD_USER}:${BUILD_USER} ./modules/ ${SRC_DIR}/nginx/

USER ${BUILD_USER}
WORKDIR ${SRC_DIR}
ARG PKG_VERSION
RUN tar cf - nginx | xz > nginx_${PKG_VERSION}.orig.tar.xz

COPY --chown=${BUILD_USER}:${BUILD_USER} ./debian ${SRC_DIR}/nginx/debian/
WORKDIR ${SRC_DIR}/nginx
ARG PKG_REL_DISTRIB
RUN sed -i "s/DebRelDistrib/${PKG_REL_DISTRIB}/;s/UNRELEASED/$(lsb_release -cs)/" ${SRC_DIR}/nginx/debian/changelog
RUN dpkg-buildpackage -us -uc

COPY --chown=${BUILD_USER}:${BUILD_USER} ./nginx-tests/ ${SRC_DIR}/nginx-tests/
COPY --chown=${BUILD_USER}:${BUILD_USER} ./run-nginx-tests.sh ${SRC_DIR}/run-nginx-tests.sh

USER root
