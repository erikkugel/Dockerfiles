FROM ghcr.io/erikkugel/slackware64:latest
ARG SLACKWARE_MIRROR=https://mirrors.slackware.com/slackware/slackware64-15.0/
COPY --chown=root:root prepare-base.sh /
COPY --chown=root:root packages /
COPY --chown=root:root slackpkg.conf /
RUN echo ${SLACKWARE_MIRROR} > /etc/slackpkg/mirrors
RUN mkdir --verbose /tar /mirror
VOLUME ["/tar", "/mirror"]
ENTRYPOINT ["bash", "/prepare-base.sh"]
