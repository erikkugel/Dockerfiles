FROM slackware64-base

RUN update-ca-certificates -v -f

ARG MIRROR
ENV MIRROR=${MIRROR:-'https://mirrors.slackware.com/slackware/slackware64-15.0/'}
RUN wget "${MIRROR}/GPG-KEY" -O- | gpg --import\
 && echo "${MIRROR}" > /etc/slackpkg/mirrors

RUN slackpkg update\
 && slackpkg upgrade-all

ENTRYPOINT ["/bin/bash", "-c"]
