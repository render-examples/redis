FROM redis:6-buster

COPY redis.conf .

# packages needed for backup/restore
RUN apt-get -qq update \
  && apt-get -qq install --upgrade -y --no-install-recommends \
  build-essential \
  magic-wormhole \
  procps \
  python3 \
  python3-dev \
  python3-pip \
  && apt-get -qq clean \
  && rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/* \
  && :

RUN pip3 install rdbtools python-lzf

ENTRYPOINT ["redis-server", "./redis.conf"]
