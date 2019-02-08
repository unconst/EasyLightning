FROM alpine
ARG VERSION=0.17.1
ARG GLIBC_VERSION=2.28-r0
ENV FILENAME bitcoin-${VERSION}-x86_64-linux-gnu.tar.gz
ENV DOWNLOAD_URL https://bitcoin.org/bin/bitcoin-core-${VERSION}/${FILENAME}

# Some of this was unabashadly yanked from
# https://github.com/szyhf/DIDockerfiles/blob/master/bitcoin/alpine/Dockerfile

RUN apk update \
  && apk --no-cache add wget tar bash ca-certificates \
  && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
  && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
  && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk \
  && apk --no-cache add glibc-${GLIBC_VERSION}.apk \
  && apk --no-cache add glibc-bin-${GLIBC_VERSION}.apk \
  && rm -rf /glibc-${GLIBC_VERSION}.apk \
  && rm -rf /glibc-bin-${GLIBC_VERSION}.apk \
  && wget $DOWNLOAD_URL \
  && tar xzvf /bitcoin-${VERSION}-x86_64-linux-gnu.tar.gz \
  && mkdir /root/.bitcoin \
  && mv /bitcoin-${VERSION}/bin/* /usr/local/bin/ \
  && rm -rf /bitcoin-${VERSION}/ \
  && rm -rf /bitcoin-${VERSION}-x86_64-linux-gnu.tar.gz \
  && apk del tar wget ca-certificates


EXPOSE 8883 8882 18309 19345

# Create a bitcoin volume at /root/.bitcoin. This folder stores chainstate, wallets, mempool etc.
# We mount the folder bitcoind/bitcoin into this volume during start up which keeps those two folders
# in linked state.
RUN mkdir -p /root/.bitcoin
VOLUME ["/root/.bitcoin"]

# Copy accross the bitcoin.conf file additional arguments to the bitcoind deamon can be set here.
COPY "bitcoin.conf" "/root/bitcoin.conf"

# Copy and CHMOD the start script. This script is run in the container when we call 'docker-compose up'.
# start-bitcoind.sh which uses config from bitcoin.conf to start eh deamon. 
# Run docker-run up --build to rebuild with new configs if you make a change bitcoind/bitcoin.conf
COPY "start-bitcoind.sh" .
RUN chmod +x start-bitcoind.sh


