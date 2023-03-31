FROM slackware64-15.0:latest
RUN slackpkg update gpg \
 && slackpkg update \
 && slackpkg upgrade-all \
 && slackpkg clean-system
