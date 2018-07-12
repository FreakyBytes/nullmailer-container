FROM alpine

ENV NULLMAILER_DEFAULT_DOMAIN="localhost.lan" \
    NULLMAILER_HELO="" \
    NULLMAILER_PAUSETIME="30" \
    NULLMAILER_REMOTE=""

ARG NM_VER=2.1
ARG NM_URL=https://github.com/bruceg/nullmailer/archive/$NM_VER.tar.gz

# download and install nullmail source
# build commands kindly stolen from https://github.com/vimagick/dockerfiles/tree/master/nullmailer
RUN set -xe \
    && apk add -U autoconf \
                  automake \
                  build-base \
                  curl \
                  gnutls \
                  gnutls-dev \
                  libstdc++ \
                  tar \
    && adduser -H -D nullmail \
    && mkdir nullmailer \
        && cd nullmailer \
        && curl -sSL $NM_URL | tar xz --strip 1 \
        && mv ChangeLog.old ChangeLog \
        && chmod +x autogen.sh \
        && ./autogen.sh \
        && ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --enable-tls \
        && make install install-root \
        && cd .. \
        && rm -rf nullmailer \
    && apk del autoconf \
               automake \
               build-base \
               curl \
               gnutls-dev \
               tar \
    && rm -rf /var/cache/apk/*

EXPOSE 25

ADD dockercmd.sh /usr/sbin/dockercmd.sh

# run the mail daemon in foreground
WORKDIR /var/spool/nullmailer/queue
CMD [ "/usr/sbin/dockercmd.sh" ]