FROM slackware64-base

COPY --chown=root:root "mirrors" "/etc/slackpkg/mirrors"

RUN update-ca-certificates -v -f

RUN slackpkg update\
 && slackpkg upgrade-all 

ENTRYPOINT ["/bin/bash", "-c"]
