FROM alpine:latest as tailscale
WORKDIR /render
ENV TSFILE=tailscale_1.12.1_amd64.tgz
RUN wget https://pkgs.tailscale.com/stable/${TSFILE} && \
  tar xzf ${TSFILE} --strip-components=1
COPY . ./

FROM redis:6-buster
WORKDIR /render
# packages needed for backup/restore
RUN apt-get -qq update \
  && apt-get -qq install --upgrade -y --no-install-recommends \
  build-essential \
  magic-wormhole \
  procps \
  python3 \
  python3-dev \
  python3-pip \
  python3-setuptools \
  && apt-get -qq clean \
  && rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/* \
  && :
RUN pip3 install rdbtools python-lzf

ADD redis.conf run.sh .

COPY --from=tailscale /render/tailscaled /render/tailscaled
COPY --from=tailscale /render/tailscale /render/tailscale
RUN mkdir -p /var/run/tailscale
RUN mkdir -p /var/cache/tailscale
RUN mkdir -p /var/lib/tailscale

RUN chown redis:redis /var/run/tailscale /var/cache/tailscale /var/lib/tailscale

USER redis
CMD ./run.sh
