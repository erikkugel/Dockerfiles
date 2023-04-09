FROM slackware64-base
ENV BINWALK_VERSION="2.3.4"

RUN wget "https://github.com/ReFirmLabs/binwalk/archive/refs/tags/v${BINWALK_VERSION}.tar.gz" -O - \
 | tar -vzxf -

RUN slackpkg install python3 python-pip
RUN python3 -m pip install --upgrade nose coverage matplotlib pycryptodome capstone

RUN ln -s /usr/bin/python3 /usr/bin/python
RUN cd binwalk-${BINWALK_VERSION} \
 && python3 setup.py install \
 && rm -rf binwalk-${BINWALK_VERSION}

RUN useradd -d /bins -g users -m binwalk
RUN chown binwalk:users /bins
USER binwalk
WORKDIR /bins
VOLUME ["/bins"]

ENTRYPOINT ["/usr/bin/binwalk"]
