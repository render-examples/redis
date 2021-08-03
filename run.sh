#!/bin/bash
/render/tailscaled --tun=userspace-networking --socks5-server=localhost:1055 &
until /render/tailscale up --authkey="${TAILSCALE_AUTHKEY}" --hostname="${RENDER_SERVICE_NAME}"
do
    sleep 0.1
done
echo "Tailscale started"
ALL_PROXY=socks5://localhost:1055/ redis-server /render/redis.conf
