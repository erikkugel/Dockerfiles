FROM ghcr.io/erikkugel/slackware64-15.0:latest
ENV BINWALK_VERSION="2.3.4"
RUN wget "https://github.com/ReFirmLabs/binwalk/archive/refs/tags/v${BINWALK_VERSION}.tar.gz" -O - \
 | tar -vzxf -
RUN cd binwalk-${BINWALK_VERSION} \
 && python3 setup.py install \
 && rm -rf binwalk-${BINWALK_VERSION}
RUN python3 -m pip install --upgrade matplotlib
RUN useradd -d /bins -g users binwalk
USER binwalk
WORKDIR /bins
VOLUME ["/bins"]
ENTRYPOINT ["binwalk"]
