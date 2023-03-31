FROM ghcr.io/erikkugel/slackware64-15.0:latest
RUN git clone https://github.com/ReFirmLabs/binwalk.git \
 && cd binwalk \
 && python3 setup.py install
RUN python3 -m pip install --upgrade matplotlib
RUN useradd -d /bins -g users binwalk
USER binwalk
WORKDIR /bins
VOLUME ["/bins"]
ENTRYPOINT ["binwalk"]
