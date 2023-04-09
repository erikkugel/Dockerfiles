FROM slackware64-tar

COPY ["slackpkg-15.0.10-noarch-1.txz",\
 "gnupg-1.4.23-x86_64-4.txz",\
 "wget-1.21.2-x86_64-1.txz",\
 "libunistring-0.9.10-x86_64-3.txz",\
 "ca-certificates-20211216-noarch-1.txz",\
 "openssl-1.1.1m-x86_64-1.txz",\
 "perl-5.34.0-x86_64-1.txz",\
 "diffutils-3.8-x86_64-1.txz",\
 "/packages/"]

RUN installpkg /packages/slackpkg-15.0.10-noarch-1.txz\
 /packages/gnupg-1.4.23-x86_64-4.txz\
 /packages/wget-1.21.2-x86_64-1.txz\
 /packages/libunistring-0.9.10-x86_64-3.txz\
 /packages/ca-certificates-20211216-noarch-1.txz\
 /packages/openssl-1.1.1m-x86_64-1.txz\
 /packages/perl-5.34.0-x86_64-1.txz\
 /packages/diffutils-3.8-x86_64-1.txz

RUN update-ca-certificates -v -f

ARG MIRROR
ENV MIRROR=${MIRROR:-'https://mirrors.slackware.com/slackware/slackware64-15.0/'}
RUN wget "${MIRROR}/GPG-KEY" -O- | gpg --import\
 && echo "${MIRROR}" > /etc/slackpkg/mirrors

ADD slackpkg.conf /etc/slackpkg/slackpkg.conf
RUN slackpkg update\
 && slackpkg remove kernel kernel-firmware\
 && slackpkg upgrade-all

ENTRYPOINT ["/bin/bash", "-c"]
